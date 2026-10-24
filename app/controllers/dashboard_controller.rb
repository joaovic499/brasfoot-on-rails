class DashboardController < ApplicationController
  before_action :return_to_live_match, only: %i[menu new_game]

  def menu
    session[:career_active] = false
    @career = Career.current
  end

  def new_game
    session[:career_active] = false
    @career = nil
    @new_game = true
    @replace_existing_career = Career.exists?
    @teams = Team.playable.sort_by(&:name)
    @teams.each { |team| team.auto_lineup!("4-3-3") unless team.lineup_ready? }
    render :show
  end

  def show
    @career = Career.current
    unless @career
      session[:career_active] = false
      return redirect_to new_game_path, status: :see_other
    end
    session[:career_active] = true

    @total_rounds = Match.maximum(:round)
    @standings = Team.standings
    @next_match = Match.next_match
    @last_match = Match.where(played: true).order(:round, :id).select(&:user_involved?).last
  end

  def start
    if Career.exists? && params[:replace_career] != "1"
      return redirect_to main_menu_path, status: :see_other,
                         alert: "Confirme no menu principal antes de substituir a carreira atual."
    end

    Career.start!(Team.find(params[:team_id]))
    session[:career_active] = true
    redirect_to career_path, status: :see_other, notice: "Carreira iniciada! Boa sorte, professor."
  end

  def play_round
    match = Match.next_match
    if match
      match.simulate!
      Match.sync_cpu_matches!
      redirect_to match_path(match), status: :see_other
    else
      redirect_to career_path, status: :see_other, alert: "A temporada acabou."
    end
  end

  def reset
    Career.reset!
    session[:career_active] = false
    redirect_to root_path, status: :see_other, notice: "Tudo zerado. Escolha um time."
  end

  private

  def return_to_live_match
    match = Match.find_by(status: %w[live halftime])
    return unless match

    redirect_to live_match_path(match), status: :see_other,
                                       alert: "Termine a partida antes de voltar ao menu principal."
  end
end
