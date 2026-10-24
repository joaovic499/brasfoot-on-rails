class SettingsController < ApplicationController
  def show
    @speed = Setting.game_speed
    @career = Career.current if session[:career_active] == true
    @pending = Match.where(played: false).count if @career
  end

  def update
    speed = params[:game_speed].to_s
    if Setting::SPEEDS.key?(speed)
      Setting.set("game_speed", speed)
      redirect_to settings_path, status: :see_other, notice: "Velocidade do jogo: #{Setting::SPEEDS[speed][:name]}."
    else
      redirect_to settings_path, status: :see_other, alert: "Velocidade inválida."
    end
  end

  # Simula todas as partidas que faltam (as do seu time e as dos outros)
  def simulate_season
    unless session[:career_active] == true && Career.current
      return redirect_to(settings_path, status: :see_other, alert: "Carregue uma carreira antes de simular a temporada.")
    end
    pending = Match.pending.to_a
    if pending.empty?
      return redirect_to(settings_path, status: :see_other, alert: "A temporada já terminou.")
    end

    pending.each(&:simulate!)
    redirect_to career_path, status: :see_other, notice: "Temporada simulada! #{pending.size} partidas jogadas."
  end
end
