class Match < ApplicationRecord
  MAX_SUBS = 5
  STRENGTH_EXP = 4.5    # quanto a diferença de força entre os times pesa nos gols esperados
  BASE_GOALS = 1.15     # gols esperados de um time contra um adversário de força igual (sem mando)
  YELLOW_P = 2.0 / 90   # ~2 amarelos por time por jogo
  RED_P = 0.025 / 90    # vermelho direto
  ASSIST_CHANCE = 0.72  # chance de um gol ter assistência
  ASSIST_SKILL_EXP = 6.0 # peso de passe/condução/ritmo na hora de decidir quem dá a assistência

  # Quem tende a dar assistência / levar cartão, por posição da vaga
  ASSIST_WEIGHT = { "GK" => 0.05, "CB" => 0.25, "LB" => 0.9, "RB" => 0.9, "CDM" => 0.7, "CM" => 1.6,
                    "LM" => 2.0, "RM" => 2.0, "CAM" => 3.0, "LW" => 2.6, "RW" => 2.6, "ST" => 1.2 }.freeze
  CARD_WEIGHT = { "GK" => 0.0, "CB" => 2.0, "LB" => 1.6, "RB" => 1.6, "CDM" => 2.4, "CM" => 1.6,
                  "LM" => 1.0, "RM" => 1.0, "CAM" => 1.0, "LW" => 0.9, "RW" => 0.9, "ST" => 1.2 }.freeze

  # Estado em memória de uma partida durante a simulação
  SimState = Struct.new(:minute, :lineups, :yellows, :goals)

  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"
  has_many :player_match_stats, dependent: :delete_all

  scope :pending, -> { where(played: false).order(:round, :id) }

  def self.next_match = pending.first
  def self.next_user_match = pending.detect(&:user_involved?)

  # Depois que o SEU jogo da rodada termina, os outros jogos da rodada são simulados
  # automaticamente (até chegar no seu próximo jogo ou no fim do campeonato).
  # Em cada rodada o jogo do seu time é sempre o primeiro da fila.
  def self.sync_cpu_matches!
    loop do
      m = pending.first
      break if m.nil? || m.user_involved?
      m.simulate!
    end
  end

  # Campeonato de pontos corridos, turno e returno, para qualquer quantidade de times
  # (método do círculo). Com N times são 2*(N-1) rodadas. Se N for ímpar, um time folga por rodada.
  # O jogo do seu time é criado primeiro em cada rodada.
  def self.generate_fixtures!(user_team = nil)
    teams = Team.playable
    raise "Precisa de pelo menos 2 times com 11+ jogadores e 1 goleiro" if teams.size < 2

    ids = teams.map(&:id).shuffle
    rounds = round_robin(ids)
    rounds += rounds.map { |pairs| pairs.map(&:reverse) } # returno: mandos invertidos

    rounds.each_with_index do |pairs, i|
      if user_team
        pairs = pairs.sort_by { |h, a| [h, a].include?(user_team.id) ? 0 : 1 }
      end
      pairs.each { |h, a| create!(home_team_id: h, away_team_id: a, round: i + 1) }
    end
  end

  # Retorna um array de rodadas; cada rodada é um array de [mandante, visitante]
  def self.round_robin(ids)
    list = ids.dup
    list << nil if list.size.odd? # folga
    n = list.size
    (n - 1).times.map do |r|
      pairs = []
      (n / 2).times do |i|
        a = list[i]
        b = list[n - 1 - i]
        next if a.nil? || b.nil?
        pairs << ((r + i).even? ? [a, b] : [b, a])
      end
      list = [list[0], list[-1], *list[1..-2]]
      pairs
    end
  end

  # ---------- eventos ----------
  def all_events
    JSON.parse(events.presence || "[]")
  end

  def goal_events
    all_events.select { |e| e["type"].nil? || e["type"] == "goal" }
  end

  def sub_events
    all_events.select { |e| e["type"] == "sub" }
  end

  def card_events
    all_events.select { |e| %w[yellow red].include?(e["type"]) }
  end

  def off_ids
    JSON.parse(subbed_off.presence || "[]")
  end

  # ---------- estado ----------
  def in_progress? = %w[live halftime].include?(status)

  def user_involved?
    tid = Career.current&.team_id
    tid && [home_team_id, away_team_id].include?(tid)
  end

  # ---------- partida ao vivo ----------
  def start!
    return unless status == "scheduled" && !played?
    prepare_lineups
    starting = { "home" => home_team.lineup.map { |e| e.player.id }, "away" => away_team.lineup.map { |e| e.player.id } }
    update!(status: "live", minute: 0, home_goals: 0, away_goals: 0, subs_home: 0, subs_away: 0,
            subbed_off: "[]", starting_ids: starting.to_json,
            events: [info_event(0, "Bola rolando! #{home_team.name} x #{away_team.name}")].to_json)
  end

  # Avança 1 minuto. Retorna os eventos gerados nesse minuto.
  def tick!
    return [] unless status == "live"
    state = SimState.new(minute, { home: home_team.lineup, away: away_team.lineup }, yellow_counts, [home_goals, away_goals])
    new_evs = step!(state)

    self.minute = state.minute
    self.home_goals, self.away_goals = state.goals

    # expulso sai do campo (a vaga fica vazia: o time joga com um a menos)
    expelled = new_evs.select { |e| e["type"] == "red" }.map { |e| e["player_id"] }
    Player.where(id: expelled).update_all(slot: nil, starter: false) if expelled.any?

    if minute == 45
      self.status = "halftime"
      new_evs << info_event(45, "Intervalo! #{home_team.name} #{home_goals} x #{away_goals} #{away_team.name}")
    elsif minute >= 90
      self.status = "finished"
      self.played = true
      new_evs << info_event(90, "Fim de jogo! #{home_team.name} #{home_goals} x #{away_goals} #{away_team.name}")
    end

    self.events = (all_events + new_evs).to_json
    save!
    if played?
      finalize_stats!
      Match.sync_cpu_matches!
    end
    new_evs
  end

  def resume!
    return [] unless status == "halftime"
    ev = info_event(45, "Começa o segundo tempo!")
    update!(status: "live", events: (all_events + [ev]).to_json)
    [ev]
  end

  # Substituição durante o jogo (banco -> campo) ou troca de posição no campo.
  def substitute!(team, slot, incoming)
    raise ArgumentError, "A partida não está em andamento." unless in_progress?
    raise ArgumentError, "Esse time não joga esta partida." unless [home_team_id, away_team_id].include?(team.id)

    home = team.id == home_team_id
    if incoming.slot.nil?
      used = home ? subs_home : subs_away
      raise ArgumentError, "Limite de #{MAX_SUBS} substituições atingido." if used >= MAX_SUBS
      raise ArgumentError, "#{incoming.name} já saiu do jogo e não pode voltar." if off_ids.include?(incoming.id)
      if slot.between?(0, team.slots.size - 1) && team.players.where(slot: slot).none?
        raise ArgumentError, "Não dá para repor jogador expulso: o time segue com um a menos."
      end
    end

    benched = team.assign_slot!(slot, incoming)
    return unless benched # foi só uma troca de posição no campo

    ev = { "type" => "sub", "minute" => minute, "team_id" => team.id, "out" => benched.name, "in" => incoming.name,
           "out_id" => benched.id, "in_id" => incoming.id,
           "text" => "🔄 #{team.name}: sai #{benched.name}, entra #{incoming.name}." }
    attrs = { events: (all_events + [ev]).to_json, subbed_off: (off_ids + [benched.id]).to_json }
    if home
      attrs[:subs_home] = subs_home + 1
    else
      attrs[:subs_away] = subs_away + 1
    end
    update!(attrs)
  end

  # Muda a formação durante o jogo (os mesmos jogadores em campo são reorganizados)
  def change_formation!(team, new_formation)
    raise ArgumentError, "A partida não está em andamento." unless in_progress?
    raise ArgumentError, "Esse time não joga esta partida." unless [home_team_id, away_team_id].include?(team.id)
    return if team.formation == new_formation

    team.change_formation!(new_formation)
    ev = { "type" => "tactic", "minute" => minute, "team_id" => team.id,
           "text" => "🔧 #{team.name} muda para o #{new_formation}." }
    update!(events: (all_events + [ev]).to_json)
  end

  # ---------- simulação instantânea (sem assistir) ----------
  # Roda os 90 minutos em memória com o mesmo motor da partida ao vivo e grava tudo de uma vez.
  def simulate!
    return if played?
    prepare_lineups
    state = SimState.new(0, { home: home_team.lineup, away: away_team.lineup }, Hash.new(0), [0, 0])
    starting = { "home" => state.lineups[:home].map { |e| e.player.id }, "away" => state.lineups[:away].map { |e| e.player.id } }

    evs = []
    90.times { evs.concat(step!(state)) }
    evs.reject! { |e| e["type"] == "chance" } # lances perigosos não precisam ficar guardados

    update!(home_goals: state.goals[0], away_goals: state.goals[1], played: true, status: "finished",
            minute: 90, events: evs.to_json, starting_ids: starting.to_json, subbed_off: "[]")
    finalize_stats!
  end

  # ---------- estatísticas por jogador ----------
  # Monta, a partir dos eventos, as linhas de PlayerMatchStat (gols, assistências, cartões, minutos e nota)
  def finalize_stats!
    evs = all_events
    start = JSON.parse(starting_ids.presence || '{"home":[],"away":[]}')
    rows = []
    now = Time.current

    [[home_team, start["home"], home_goals, away_goals], [away_team, start["away"], away_goals, home_goals]].each do |team, ids, gf, ga|
      spans = {} # player_id => { in:, out: }
      ids.each { |pid| spans[pid] = { in: 0, out: 90 } }
      evs.each do |e|
        next unless e["team_id"] == team.id
        case e["type"]
        when "sub"
          spans[e["out_id"]][:out] = e["minute"] if spans[e["out_id"]]
          spans[e["in_id"]] = { in: e["minute"], out: 90 }
        when "red"
          spans[e["player_id"]][:out] = e["minute"] if spans[e["player_id"]]
        end
      end

      players = Player.where(id: spans.keys).index_by(&:id)
      spans.each do |pid, span|
        pl = players[pid]
        next unless pl
        goals = evs.count { |e| e["type"] == "goal" && e["player_id"] == pid }
        assists = evs.count { |e| e["type"] == "goal" && e["assist_id"] == pid }
        yellows = evs.count { |e| e["type"] == "yellow" && e["player_id"] == pid }
        reds = evs.count { |e| e["type"] == "red" && e["player_id"] == pid }
        minutes = [span[:out] - span[:in], 0].max
        rows << { match_id: id, player_id: pid, team_id: team.id, goals: goals, assists: assists,
                  yellow_cards: yellows, red_cards: reds, minutes: minutes,
                  rating: compute_rating(pl, goals, assists, yellows, reds, minutes, gf, ga),
                  created_at: now, updated_at: now }
      end
    end

    PlayerMatchStat.where(match_id: id).delete_all
    PlayerMatchStat.insert_all(rows) if rows.any?
  end

  private

  # ---------- motor da simulação (1 minuto) ----------
  def step!(state)
    state.minute += 1
    m = state.minute
    hl = state.lineups[:home]
    al = state.lineups[:away]
    return [] if hl.empty? || al.empty?

    lam_h = expected_goals(home_team.attack(hl), away_team.defense(al), 1.12) * manpower(hl.size, al.size)
    lam_a = expected_goals(away_team.attack(al), home_team.defense(hl), 1.0) * manpower(al.size, hl.size)

    new_evs = []
    [[:home, home_team, lam_h, :away], [:away, away_team, lam_a, :home]].each do |side, team, lam, opp|
      lineup = state.lineups[side]
      pg = lam / 90.0
      r = rand
      if r < pg
        new_evs << goal_event(team, lineup, m)
        state.goals[side == :home ? 0 : 1] += 1
      elsif r < pg * 3.5
        new_evs << chance_event(team, lineup, state.lineups[opp], m)
      end
    end

    [[:home, home_team], [:away, away_team]].each do |side, team|
      new_evs.concat(card_events_for(team, state, side, m))
    end
    new_evs
  end

  # Jogar com um a menos pesa (e jogar contra um a menos ajuda)
  def manpower(own, opp)
    ((own / 11.0) / ([opp, 1].max / 11.0))**1.5
  end

  def card_events_for(team, state, side, min)
    lineup = state.lineups[side]
    return [] if lineup.size < 8
    r = rand
    evs = []
    if r < RED_P
      entry = pick_weighted(lineup) { |e| CARD_WEIGHT[e.slot_pos] * (e.player.aggression / 65.0) }
      evs << red_event(team, entry.player, min, "leva o vermelho direto")
      lineup.delete(entry)
    elsif r < RED_P + YELLOW_P
      # quem já tem amarelo se cuida mais: é bem menos provável tomar o segundo
      entry = pick_weighted(lineup) { |e| CARD_WEIGHT[e.slot_pos] * (e.player.aggression / 65.0) * (state.yellows[e.player.id] >= 1 ? 0.25 : 1.0) }
      pid = entry.player.id
      state.yellows[pid] += 1
      evs << { "type" => "yellow", "minute" => min, "team_id" => team.id, "player" => entry.player.name,
               "player_id" => pid, "text" => "🟨 Cartão amarelo para #{entry.player.name} (#{team.short_name})." }
      if state.yellows[pid] >= 2
        evs << red_event(team, entry.player, min, "é expulso pelo segundo amarelo")
        lineup.delete(entry)
      end
    end
    evs
  end

  def red_event(team, player, min, why)
    { "type" => "red", "minute" => min, "team_id" => team.id, "player" => player.name, "player_id" => player.id,
      "text" => "🟥 EXPULSO! #{player.name} (#{team.short_name}) #{why}." }
  end

  def goal_event(team, lineup, min)
    scorer_entry = pick_weighted(lineup, &:scorer_weight)
    scorer = scorer_entry.player
    assist_entry = nil
    if rand < ASSIST_CHANCE
      others = lineup - [scorer_entry]
      assist_entry = pick_weighted(others) { |e| ASSIST_WEIGHT[e.slot_pos] * (e.player.creativity / 75.0)**ASSIST_SKILL_EXP * (e.rating / 80.0) } if others.any?
    end
    text = "⚽ GOOOL! #{scorer.name} marca para o #{team.name}!"
    text += " Assistência de #{assist_entry.player.name}." if assist_entry
    { "type" => "goal", "minute" => min, "team_id" => team.id, "player" => scorer.name, "player_id" => scorer.id,
      "assist" => assist_entry&.player&.name, "assist_id" => assist_entry&.player&.id, "text" => text }
  end

  def chance_event(team, lineup, opp_lineup, min)
    shooter = pick_weighted(lineup, &:scorer_weight).player
    keeper = opp_lineup.find { |e| e.slot_pos == "GK" }&.player
    texts = [
      "#{shooter.name} chuta de fora da área e a bola passa perto.",
      "#{shooter.name} cabeceia, mas a bola sai pela linha de fundo.",
      "#{shooter.name} finaliza e acerta a trave!"
    ]
    texts << "#{keeper.name} faz grande defesa no chute de #{shooter.name}!" if keeper
    { "type" => "chance", "minute" => min, "team_id" => team.id, "text" => "#{team.short_name}: #{texts.sample}" }
  end

  def yellow_counts
    counts = Hash.new(0)
    all_events.each { |e| counts[e["player_id"]] += 1 if e["type"] == "yellow" }
    counts
  end

  def prepare_lineups
    [home_team, away_team].each do |t|
      if t.user_controlled?
        t.fill_empty_slots! # ex.: jogador expulso no jogo anterior
      elsif !t.lineup_ready?
        t.auto_lineup!
      end
    end
  end

  def info_event(min, text)
    { "type" => "info", "minute" => min, "text" => text }
  end

  # Quanto maior a razão ataque/defesa, mais gols esperados
  def expected_goals(att, defn, bonus)
    (BASE_GOALS * (att / defn)**STRENGTH_EXP * bonus).clamp(0.2, 4.5)
  end

  # Sorteio ponderado: o bloco devolve o peso de cada item
  def pick_weighted(items)
    total = items.sum { |i| yield(i) }
    return items.sample if total <= 0
    r = rand * total
    items.each do |i|
      r -= yield(i)
      return i if r <= 0
    end
    items.last
  end

  # Nota da partida (3.0 a 10.0): qualidade do jogador, gols, assistências, cartões,
  # resultado do time, solidez defensiva e um pouco de sorte.
  def compute_rating(player, goals, assists, yellows, reds, minutes, gf, ga)
    r = 6.0 + (player.overall - 75) * 0.02
    r += 1.0 * [goals, 4].min + 0.7 * [assists, 3].min
    r -= 0.2 * yellows + 1.5 * reds
    r += gf > ga ? 0.4 : (gf < ga ? -0.3 : 0.0)
    if %w[GK DF].include?(player.group)
      r += 0.5 if ga.zero?
      r -= 0.2 * [ga, 4].min
    end
    r += (rand + rand + rand - 1.5) * 0.8 # variação aleatória (~±1)
    weight = 0.35 + 0.65 * [minutes / 90.0, 1.0].min # quem jogou pouco tem nota mais "neutra"
    r = 6.0 + (r - 6.0) * weight
    r.clamp(3.0, 10.0).round(1)
  end
end
