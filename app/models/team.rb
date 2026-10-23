class Team < ApplicationRecord
  POS_ORDER = Positions::ORDER

  has_many :players, dependent: :destroy

  # Um titular em campo: jogador + posição da vaga + força efetiva nessa vaga
  Entry = Struct.new(:player, :slot_pos, :rating) do
    def group = Positions.group(slot_pos)
    def scorer_weight = Positions::ALL[slot_pos][:weight] * (rating / 80.0)**3
  end

  Standing = Struct.new(:team, :played, :won, :drawn, :lost, :gf, :ga, :points, keyword_init: true) do
    def gd = gf - ga
  end

  def user_controlled?
    Career.current&.team_id == id
  end

  def slots
    Formations::ALL[formation] || Formations::ALL["4-3-3"]
  end

  # Time apto a disputar o campeonato: 11+ jogadores e pelo menos 1 goleiro
  def playable?
    players.count >= 11 && players.where(position: "GK").exists?
  end

  def self.playable
    all.order(:id).select(&:playable?)
  end

  # Tem 11 titulares posicionados?
  def lineup_ready?
    Formations::ALL.key?(formation) && players.where(starter: true).where.not(slot: nil).count >= 11
  end

  # Titulares com a força já ajustada pela posição
  def lineup
    defs = slots
    players.where(starter: true).where.not(slot: nil).map do |p|
      pos = defs[p.slot][0]
      Entry.new(p, pos, p.rating_at(pos))
    end
  end

  def sorted_players
    players.to_a.sort_by { |p| [POS_ORDER.index(p.position), -p.overall] }
  end

  def sector(group, list = lineup)
    xs = list.select { |e| e.group == group }.map(&:rating)
    xs.empty? ? 50.0 : xs.sum.to_f / xs.size
  end

  def attack(list = lineup)
    0.55 * sector("FW", list) + 0.35 * sector("MF", list) + 0.10 * sector("DF", list)
  end

  def defense(list = lineup)
    0.45 * sector("DF", list) + 0.30 * sector("MF", list) + 0.25 * sector("GK", list)
  end

  def overall(list = lineup)
    return 0 if list.empty?
    (list.sum(&:rating).to_f / list.size).round(1)
  end

  # Escala os melhores para a formação, respeitando posições naturais (guloso por força efetiva)
  def auto_lineup!(new_formation = nil)
    new_formation ||= formation
    new_formation = "4-3-3" if new_formation.blank?
    raise ArgumentError, "Formação inválida" unless Formations::ALL.key?(new_formation)
    defs = Formations::ALL[new_formation]

    transaction do
      update!(formation: new_formation)
      players.update_all(starter: false, slot: nil)
      all = Player.where(team_id: id).to_a
      used_players = {}
      used_slots = {}

      gk_slot = defs.index { |d| d[0] == "GK" }
      gk = all.select { |p| p.position == "GK" }.max_by(&:overall)
      if gk_slot && gk
        gk.update_columns(starter: true, slot: gk_slot)
        used_players[gk.id] = true
        used_slots[gk_slot] = true
      end

      pairs = []
      all.each do |p|
        next if p.position == "GK"
        defs.each_index do |s|
          next if defs[s][0] == "GK"
          pairs << [-p.rating_at(defs[s][0]), -p.overall, (defs[s][1] - 50).abs, s, p]
        end
      end
      pairs.sort_by! { |a| a[0..3] }
      pairs.each do |_r, _o, _c, s, p|
        next if used_players[p.id] || used_slots[s]
        p.update_columns(starter: true, slot: s)
        used_players[p.id] = true
        used_slots[s] = true
      end
    end
  end

  # Muda a formação MANTENDO os mesmos 11 em campo, reorganizando-os da melhor forma
  def change_formation!(new_formation)
    raise ArgumentError, "Formação inválida" unless Formations::ALL.key?(new_formation)
    return if new_formation == formation

    starters = players.where(starter: true).to_a
    defs = Formations::ALL[new_formation]
    arrangement = optimal_arrangement(starters, defs)
    return auto_lineup!(new_formation) unless arrangement

    transaction do
      update!(formation: new_formation)
      players.update_all(slot: nil)
      starters.each_with_index { |p, i| p.update_columns(starter: true, slot: arrangement[i]) }
    end
  end

  # Coloca o jogador na vaga (troca com quem estiver lá). Qualquer posição vale, com penalidade,
  # exceto goleiro (só goleiro joga no gol). Retorna o ocupante que foi pro banco (ou nil).
  def assign_slot!(slot, incoming)
    defs = slots
    raise ArgumentError, "Posição inválida." unless slot.between?(0, defs.size - 1)
    if (defs[slot][0] == "GK") != (incoming.position == "GK")
      raise ArgumentError, "Só goleiro joga no gol (e goleiro não joga na linha)."
    end

    benched = nil
    Player.transaction do
      occupant = players.find_by(slot: slot)
      old_slot = incoming.slot
      if occupant && occupant.id != incoming.id
        occupant.update!(slot: old_slot, starter: !old_slot.nil?)
        benched = occupant if old_slot.nil?
      end
      incoming.update!(slot: slot, starter: true)
    end
    benched
  end

  # Depois de editar jogadores: tira da escalação quem ficou em vaga inválida e preenche buracos
  def repair_lineup!
    defs = slots
    players.where.not(slot: nil).each do |pl|
      invalid = pl.slot >= defs.size || ((defs[pl.slot][0] == "GK") != (pl.position == "GK"))
      pl.update_columns(slot: nil, starter: false) if invalid
    end
    fill_empty_slots!
  end

  # Coloca o melhor reserva disponível em cada vaga vazia
  def fill_empty_slots!
    defs = slots
    taken = players.where.not(slot: nil).pluck(:slot)
    ((0...defs.size).to_a - taken).each do |s|
      pos = defs[s][0]
      candidates = players.where(slot: nil).to_a.select { |p| (pos == "GK") == (p.position == "GK") }
      best = candidates.max_by { |p| p.rating_at(pos) }
      best&.update_columns(slot: s, starter: true)
    end
  end

  def lineup_by_slot
    players.to_a.select(&:slot).index_by(&:slot)
  end

  def bench_players
    players.to_a.reject(&:slot).sort_by { |p| [POS_ORDER.index(p.position), -p.overall] }
  end

  def self.standings
    ids = Match.pluck(:home_team_id, :away_team_id).flatten.uniq
    teams = ids.empty? ? Team.playable : Team.where(id: ids).to_a
    rows = teams.each_with_object({}) do |t, h|
      h[t.id] = Standing.new(team: t, played: 0, won: 0, drawn: 0, lost: 0, gf: 0, ga: 0, points: 0)
    end
    Match.where(played: true).each do |m|
      h = rows[m.home_team_id]
      a = rows[m.away_team_id]
      h.played += 1; a.played += 1
      h.gf += m.home_goals; h.ga += m.away_goals
      a.gf += m.away_goals; a.ga += m.home_goals
      if m.home_goals > m.away_goals
        h.won += 1; h.points += 3; a.lost += 1
      elsif m.home_goals < m.away_goals
        a.won += 1; a.points += 3; h.lost += 1
      else
        h.drawn += 1; a.drawn += 1; h.points += 1; a.points += 1
      end
    end
    rows.values.sort_by { |s| [-s.points, -s.gd, -s.gf, s.team.name] }
  end

  private

  # Programação dinâmica: distribui os jogadores nas vagas maximizando a força total.
  # Retorna um array com o índice da vaga de cada jogador (ou nil se for impossível).
  def optimal_arrangement(plyrs, defs)
    n = plyrs.size
    m = defs.size
    return nil if n > m || n.zero?

    neg = -1_000_000
    size = 1 << m
    best = Array.new(size, neg)
    parent = Array.new(size)
    best[0] = 0

    size.times do |mask|
      next if best[mask] == neg
      i = mask.to_s(2).count("1") # quantos jogadores já foram colocados
      next if i >= n
      pl = plyrs[i]
      m.times do |s|
        next if mask & (1 << s) != 0
        pos = defs[s][0]
        next if (pos == "GK") != (pl.position == "GK")
        nm = mask | (1 << s)
        cand = best[mask] + pl.rating_at(pos)
        if cand > best[nm]
          best[nm] = cand
          parent[nm] = [mask, s]
        end
      end
    end

    final = (0...size).select { |mk| mk.to_s(2).count("1") == n && best[mk] > neg }.max_by { |mk| best[mk] }
    return nil unless final

    result = Array.new(n)
    mask = final
    while mask != 0
      prev, s = parent[mask]
      result[prev.to_s(2).count("1")] = s
      mask = prev
    end
    result
  end
end
