# Configurações do jogo (chave/valor). Por enquanto: velocidade da partida ao vivo.
class Setting < ApplicationRecord
  # Milissegundos reais por minuto de jogo => descrição (uma partida de 90' dura ~ 90 x esse valor)
  SPEEDS = {
    "1000" => { name: "Lenta",  desc: "1 minuto de jogo por segundo (partida em ~1min30)" },
    "500"  => { name: "Normal", desc: "2 minutos de jogo por segundo (partida em ~45s)" },
    "200"  => { name: "Rápida", desc: "5 minutos de jogo por segundo (partida em ~18s)" },
    "50"   => { name: "Turbo",  desc: "20 minutos de jogo por segundo (partida em ~5s)" }
  }.freeze

  DEFAULTS = { "game_speed" => "500" }.freeze

  validates :key, presence: true, uniqueness: true

  def self.get(key)
    find_by(key: key)&.value || DEFAULTS[key]
  end

  def self.set(key, value)
    rec = find_or_initialize_by(key: key)
    rec.update!(value: value.to_s)
    rec
  end

  def self.game_speed
    v = get("game_speed")
    SPEEDS.key?(v) ? v : DEFAULTS["game_speed"]
  end
end
