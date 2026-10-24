class Career < ApplicationRecord
  belongs_to :team

  def self.current
    order(:id).last
  end

  # Nova carreira: o calendário é montado com os jogos do SEU time primeiro
  def self.start!(team)
    transaction do
      destroy_all
      Match.destroy_all
      PlayerTemplate.sync_to_players!
      Match.generate_fixtures!(team)
      Team.playable.each { |t| t.auto_lineup!("4-3-3") }
      create!(team: team)
    end
    Match.sync_cpu_matches! # se o seu time folgar na 1ª rodada (nº ímpar de times)
  end

  # Zera tudo: partidas, carreira e escalações
  def self.reset!
    transaction do
      destroy_all
      Match.destroy_all
      Match.generate_fixtures!
      Team.playable.each { |t| t.auto_lineup!("4-3-3") }
    end
  end
end
