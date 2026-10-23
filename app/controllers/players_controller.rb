class PlayersController < ApplicationController
  def index
    @teams = Team.order(:name)
    @team = Team.find_by(id: params[:team_id]) || Career.current&.team || @teams.first
    @players = @team ? @team.sorted_players : []
  end

  # Salva todos os jogadores da tela de uma vez (só grava quem foi alterado)
  def bulk
    rows = params[:players] || {}
    players = Player.where(id: rows.keys).index_by { |p| p.id.to_s }
    teams = []
    old_teams = []
    errors = []
    updated = 0

    rows.each do |id, attrs|
      pl = players[id.to_s]
      next unless pl
      a = attrs.permit(:name, :overall, :position, :team_id, :alt1, :alt2)

      old_team = pl.team
      pl.assign_attributes(a.slice(:name, :overall, :position, :team_id))
      pl.alt_positions = [a[:alt1], a[:alt2]].map(&:to_s).reject(&:blank?).uniq.join(",")
      next unless pl.changed?

      moved = pl.team_id_changed?
      pl.slot = nil if moved || pl.position_changed? # volta pro banco; o reparo reescala se precisar
      pl.starter = false if pl.slot.nil?

      if pl.save
        updated += 1
        teams << old_team << pl.team
        old_teams << old_team if moved
      else
        errors << "#{pl.name}: #{pl.errors.full_messages.to_sentence}"
      end
    end

    refresh_lineups(teams.uniq)

    notice = updated.zero? ? "Nenhuma alteração para salvar." : "#{updated} jogador(es) atualizado(s)."
    short = old_teams.uniq.reject { |t| t.reload.playable? }
    notice += " Atenção: #{short.map(&:name).join(', ')} ficou sem elenco mínimo (11 jogadores e 1 goleiro)." if short.any?
    flash_opts = { notice: notice }
    flash_opts[:alert] = "Não salvou: #{errors.join(' | ')}" if errors.any?
    redirect_to players_path(team_id: params[:view_team_id]), status: :see_other, **flash_opts
  end

  def create
    pl = Player.new(player_params)
    pl.alt_positions = alts_from_params
    if pl.save
      refresh_lineups([pl.team])
      redirect_to players_path(team_id: pl.team_id), status: :see_other, notice: "#{pl.name} adicionado."
    else
      redirect_to players_path(team_id: params[:view_team_id]), status: :see_other,
                  alert: "Não foi possível criar: #{pl.errors.full_messages.to_sentence}"
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :overall, :position, :team_id)
  end

  def alts_from_params
    [params.dig(:player, :alt1), params.dig(:player, :alt2)].map(&:to_s).reject(&:blank?).uniq.join(",")
  end

  # Time da CPU escolhe o melhor 11 de novo; no seu time só conserta o que quebrou
  def refresh_lineups(teams)
    teams.each do |t|
      t.reload
      t.user_controlled? ? t.repair_lineup! : t.auto_lineup!
    end
  end
end
