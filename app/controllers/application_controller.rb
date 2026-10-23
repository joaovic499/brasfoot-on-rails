class ApplicationController < ActionController::Base
  before_action :lock_during_match

  private

  # Durante uma partida (ao vivo ou no intervalo) só dá para ficar na tela do jogo
  def lock_during_match
    match = Match.find_by(status: %w[live halftime])
    return unless match
    return if is_a?(MatchesController) && params[:id].to_i == match.id
    redirect_to live_match_path(match), status: :see_other, alert: "Termine a partida antes de sair da tela."
  end
end
