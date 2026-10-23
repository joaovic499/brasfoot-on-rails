class DashboardController < ApplicationController
  def show
    @career = Career.current
    unless @career
      @teams = Team.playable.sort_by(&:name)
      # times cadastrados à mão podem estar sem escalação: monta automaticamente
      @teams.each { |t| t.auto_lineup!("4-3-3") unless t.lineup_ready? }
      return
    end
    @total_rounds = Match.maximum(:round)
    @standings = Team.standings
    @next_match = Match.next_match
    @last_match = Match.where(played: true).order(:round, :id).select(&:user_involved?).last
  end

  def start
    Career.start!(Team.find(params[:team_id]))
    redirect_to root_path, status: :see_other, notice: "Carreira iniciada! Boa sorte, professor."
  end

  def play_round
    match = Match.next_match
    if match
      match.simulate!
      Match.sync_cpu_matches!
      redirect_to match_path(match), status: :see_other
    else
      redirect_to root_path, status: :see_other, alert: "A temporada acabou."
    end
  end

  def play_all
    Match.pending.each(&:simulate!)
    redirect_to root_path, status: :see_other, notice: "Temporada simulada!"
  end

  def reset
    Career.reset!
    redirect_to root_path, status: :see_other, notice: "Tudo zerado. Escolha um time."
  end
end
