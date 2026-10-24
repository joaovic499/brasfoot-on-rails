class PlayersController < ApplicationController
  # Com uma carreira em andamento os jogadores ficam congelados (só consulta)
  before_action :block_edits_during_career, only: %i[bulk create]

  def index
    @teams = Team.order(:name)
    @team = Team.find_by(id: params[:team_id]) || @teams.first
    @players = @team ? PlayerTemplate.where(team_id: @team.id).sort_by { |player| [Positions::ORDER.index(player.position), -player.overall] } : []
    @locked = session[:career_active] == true
  end

  # Salva todos os jogadores da tela de uma vez (só grava quem foi alterado)
  def bulk
    rows = params[:players] || {}
    players = PlayerTemplate.where(id: rows.keys).index_by { |player| player.id.to_s }
    errors = []
    updated = 0

    rows.each do |id, attrs|
      template = players[id.to_s]
      next unless template
      a = attrs.permit(:name, :overall, :position, :team_id, :alt1, :alt2, :age, :stamina, :photo_url, *Player::ATTRS)

      template.assign_attributes(a.slice(:name, :overall, :position, :team_id, :age, :stamina, :photo_url, *Player::ATTRS))
      template.alt_positions = [a[:alt1], a[:alt2]].map(&:to_s).reject(&:blank?).uniq.join(",")
      # mudou atributos e não mexeu na Força: a Força é recalculada pelos atributos
      if (template.changed & PlayerTemplate::ATTRS.map(&:to_s)).any? && !template.overall_changed? && (calc = template.overall_from_attrs)
        template.overall = calc
      end
      next unless template.changed?

      if template.save
        updated += 1
      else
        errors << "#{template.name}: #{template.errors.full_messages.to_sentence}"
      end
    end

    notice = updated.zero? ? "Nenhuma alteração para salvar." : "#{updated} jogador(es) da base atualizados."
    flash_opts = { notice: notice }
    flash_opts[:alert] = "Não salvou na base: #{errors.join(' | ')}" if errors.any?
    redirect_to players_path(team_id: params[:view_team_id]), status: :see_other, **flash_opts
  end

  def create
    template = PlayerTemplate.new(player_params)
    template.alt_positions = alts_from_params
    template.overall = template.overall_from_attrs || template.overall
    if template.save
      redirect_to players_path(team_id: template.team_id), status: :see_other, notice: "#{template.name} adicionado à base de jogadores."
    else
      redirect_to players_path(team_id: params[:view_team_id]), status: :see_other,
                  alert: "Não foi possível adicionar à base: #{template.errors.full_messages.to_sentence}"
    end
  end

  private

  def block_edits_during_career
    return unless session[:career_active] == true
    redirect_to players_path, status: :see_other,
                alert: "Edição da base bloqueada enquanto a carreira está aberta. Saia para o menu principal; o save será mantido."
  end

  def player_params
    params.require(:player).permit(:name, :overall, :position, :team_id, :age, :stamina, *PlayerTemplate::ATTRS)
  end

  def alts_from_params
    [params.dig(:player, :alt1), params.dig(:player, :alt2)].map(&:to_s).reject(&:blank?).uniq.join(",")
  end

end
