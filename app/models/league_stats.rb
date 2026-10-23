# Estatísticas acumuladas da temporada (somando as partidas de cada jogador)
class LeagueStats
  Row = Struct.new(:player, :team, :games, :goals, :assists, :yellows, :reds, :avg_rating, :minutes, keyword_init: true)

  # Ordenações aceitas na tabela do seu time
  SORTS = {
    "name"       => ->(r) { r.player.name.to_s.downcase },
    "position"   => ->(r) { Positions::ORDER.index(r.player.position) || 99 },
    "overall"    => ->(r) { r.player.overall },
    "games"      => ->(r) { r.games },
    "goals"      => ->(r) { r.goals },
    "assists"    => ->(r) { r.assists },
    "yellows"    => ->(r) { r.yellows },
    "reds"       => ->(r) { r.reds },
    "avg_rating" => ->(r) { r.avg_rating || -1 },
    "minutes"    => ->(r) { r.minutes }
  }.freeze

  # Todos os jogadores que já atuaram, com os totais
  def rows
    @rows ||= begin
      data = PlayerMatchStat.group(:player_id).pluck(
        :player_id, Arel.sql("COUNT(*)"), Arel.sql("SUM(goals)"), Arel.sql("SUM(assists)"),
        Arel.sql("SUM(yellow_cards)"), Arel.sql("SUM(red_cards)"), Arel.sql("AVG(rating)"), Arel.sql("SUM(minutes)")
      )
      players = Player.includes(:team).where(id: data.map(&:first)).index_by(&:id)
      data.filter_map do |pid, games, g, a, y, r, avg, min|
        pl = players[pid]
        next unless pl
        Row.new(player: pl, team: pl.team, games: games.to_i, goals: g.to_i, assists: a.to_i,
                yellows: y.to_i, reds: r.to_i, avg_rating: avg.to_f.round(2), minutes: min.to_i)
      end
    end
  end

  def top_scorers(limit = 15)
    rows.select { |r| r.goals.positive? }
        .sort_by { |r| [-r.goals, -r.assists, r.games, r.player.name] }.first(limit)
  end

  def top_assists(limit = 15)
    rows.select { |r| r.assists.positive? }
        .sort_by { |r| [-r.assists, -r.goals, r.games, r.player.name] }.first(limit)
  end

  # Para a média de notas valer, o jogador precisa ter um mínimo de jogos (40% das rodadas disputadas)
  def min_games_for_rating
    rounds = Match.where(played: true).maximum(:round).to_i
    [(rounds * 0.4).floor, 1].max
  end

  def best_rated(limit = 15)
    min = min_games_for_rating
    rows.select { |r| r.games >= min }
        .sort_by { |r| [-r.avg_rating, -r.games, r.player.name] }.first(limit)
  end

  # Todos os jogadores do elenco (mesmo quem ainda não jogou), com a ordenação escolhida
  def team_rows(team, sort: "goals", dir: "desc")
    by_player = rows.index_by { |r| r.player.id }
    list = team.players.map do |pl|
      by_player[pl.id] || Row.new(player: pl, team: team, games: 0, goals: 0, assists: 0,
                                  yellows: 0, reds: 0, avg_rating: nil, minutes: 0)
    end
    sort = "goals" unless SORTS.key?(sort)
    sorted = list.sort_by { |r| [SORTS[sort].call(r), r.player.name] }
    dir == "asc" ? sorted : sorted.reverse
  end
end
