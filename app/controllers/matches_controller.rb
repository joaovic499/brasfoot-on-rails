class MatchesController < ApplicationController
  before_action :set_match, only: %i[show live start tick resume substitute formation]
  before_action :require_career, only: %i[live start tick resume substitute formation]

  def index
    @career = Career.current
    @show_all = params[:all].present?
    tid = @career&.team_id
    matches = Match.includes(:home_team, :away_team).order(:round, :id).to_a
    @matches = @show_all ? matches : matches.select { |m| [m.home_team_id, m.away_team_id].include?(tid) }
  end

  def show
    unless @match.played?
      target = @match.user_involved? ? live_match_path(@match) : matches_path
      return redirect_to(target, status: :see_other)
    end
    @stats = @match.player_match_stats.includes(:player).order(rating: :desc).to_a
  end

  # Tela da partida ao vivo
  def live
    return redirect_to(match_path(@match), status: :see_other) if @match.played?
    unless @match.user_involved?
      return redirect_to(root_path, status: :see_other, alert: "Você só acompanha as partidas do seu time.")
    end

    @team = @career.team
    @by_slot = @team.lineup_by_slot
    @bench = @team.bench_players
    @banned = @match.off_ids
    @subs_used = @team.id == @match.home_team_id ? @match.subs_home : @match.subs_away
    @speed = Setting.game_speed
  end

  def start
    @match.start! if Match.next_match == @match
    redirect_to live_match_path(@match), status: :see_other
  end

  # Avança 1 minuto (chamado pelo JavaScript a cada poucos instantes)
  def tick
    evs = @match.tick!
    render json: state_json(evs)
  end

  def resume
    evs = @match.resume!
    render json: state_json(evs)
  end

  def substitute
    team = @career.team
    incoming = team.players.find(params[:player_id])
    @match.substitute!(team, params[:slot].to_i, incoming)
    redirect_to live_match_path(@match), status: :see_other, notice: "Escalação atualizada."
  rescue ArgumentError => e
    redirect_to live_match_path(@match), status: :see_other, alert: e.message
  end

  def formation
    @match.change_formation!(@career.team, params[:formation])
    redirect_to live_match_path(@match), status: :see_other, notice: "Formação alterada para #{params[:formation]}."
  rescue ArgumentError => e
    redirect_to live_match_path(@match), status: :see_other, alert: e.message
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def require_career
    @career = Career.current
    redirect_to root_path, status: :see_other, alert: "Escolha um time primeiro." unless @career
  end

  def state_json(evs)
    { minute: @match.minute, status: @match.status,
      home_goals: @match.home_goals, away_goals: @match.away_goals, events: evs }
  end
end
