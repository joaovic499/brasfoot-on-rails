class SquadController < ApplicationController
  before_action :require_career

  def show
    @team = @career.team
    # garante que todo titular tenha posição no campo
    @team.auto_lineup! if @team.players.where(starter: true, slot: nil).exists?
    players = @team.players.to_a
    @by_slot = players.select(&:slot).index_by(&:slot)
    @bench = players.reject(&:slot).sort_by { |p| [Team::POS_ORDER.index(p.position), -p.overall] }
  end

  # Coloca um jogador numa posição do campo (troca com quem estiver lá)
  def assign
    team = @career.team
    team.assign_slot!(params[:slot].to_i, team.players.find(params[:player_id]))
    back_with(notice: "Escalação atualizada.")
  rescue ArgumentError => e
    back_with(alert: e.message)
  end

  def formation
    @career.team.change_formation!(params[:formation])
    back_with(notice: "Formação #{params[:formation]} montada com os mesmos titulares.")
  rescue ArgumentError
    back_with(alert: "Formação inválida.")
  end

  def auto
    @career.team.auto_lineup!
    back_with(notice: "Melhor time escalado.")
  end

  private

  def back_with(flash_opts)
    redirect_to squad_path, status: :see_other, **flash_opts
  end

  def require_career
    @career = Career.current
    redirect_to root_path, status: :see_other, alert: "Escolha um time primeiro." unless @career
  end
end
