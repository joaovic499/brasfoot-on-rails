# Desempenho de um jogador em UMA partida (gols, assistências, cartões, minutos e nota)
class PlayerMatchStat < ApplicationRecord
  belongs_to :match
  belongs_to :player
end
