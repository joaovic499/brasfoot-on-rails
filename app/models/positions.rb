# Posições estilo FIFA. x = lado (-2 esquerda ... 2 direita), y = profundidade (0 gol ... 5.4 ataque).
#
# Cada jogador tem 1 posição principal + até 2 secundárias.
#   - Jogando em qualquer uma das suas posições (principal ou secundária): SEM perda de força.
#   - Jogando numa posição que não está na lista: perde força conforme a distância até a posição
#     MAIS PRÓXIMA da lista dele:
#         d = |dx| * 1.5 + |dy| * 3
#         penalidade = OFF_BASE + OFF_SCALE * d   (arredondada)
#
# Exemplos: Lewandowski (só ST) de RW: -5 | Yamal (só RW) de CM: -9
#           Dembélé (LW, ST, RW) em qualquer uma das 3: 0
# Para deixar mais leve/pesado, mexa em OFF_BASE e OFF_SCALE.
module Positions
  ALL = {
    "GK"  => { name: "Goleiro",            group: "GK", x: 0,  y: 0,   weight: 0.0 },
    "CB"  => { name: "Zagueiro",           group: "DF", x: 0,  y: 1,   weight: 0.6 },
    "LB"  => { name: "Lateral esquerdo",   group: "DF", x: -2, y: 1.5, weight: 0.9 },
    "RB"  => { name: "Lateral direito",    group: "DF", x: 2,  y: 1.5, weight: 0.9 },
    "CDM" => { name: "Volante",            group: "MF", x: 0,  y: 2,   weight: 0.9 },
    "CM"  => { name: "Meio-campo central", group: "MF", x: 0,  y: 3,   weight: 1.8 },
    "LM"  => { name: "Ala esquerdo",       group: "MF", x: -2, y: 4,   weight: 2.5 },
    "RM"  => { name: "Ala direito",        group: "MF", x: 2,  y: 4,   weight: 2.5 },
    "CAM" => { name: "Meia armador",       group: "MF", x: 0,  y: 4,   weight: 3.5 },
    "LW"  => { name: "Ponta esquerda",     group: "FW", x: -2, y: 5,   weight: 4.5 },
    "RW"  => { name: "Ponta direita",      group: "FW", x: 2,  y: 5,   weight: 4.5 },
    "ST"  => { name: "Atacante",           group: "FW", x: 0,  y: 5.4, weight: 6.0 }
  }.freeze

  ORDER = ALL.keys.freeze
  GROUP_NAMES = { "GK" => "Goleiros", "DF" => "Defensores", "MF" => "Meio-campistas", "FW" => "Atacantes" }.freeze

  OFF_BASE = 1.5
  OFF_SCALE = 0.85

  def self.group(pos) = ALL[pos][:group]

  def self.distance(a_pos, b_pos)
    a = ALL[a_pos]
    b = ALL[b_pos]
    (a[:x] - b[:x]).abs * 1.5 + (a[:y] - b[:y]).abs * 3.0
  end

  # positions = lista de posições do jogador (principal + secundárias)
  def self.penalty_for(positions, to)
    return 0 if positions.include?(to)
    return 40 if group(to) == "GK" || positions.any? { |p| group(p) == "GK" } # goleiro só joga no gol
    d = positions.map { |p| distance(p, to) }.min
    (OFF_BASE + OFF_SCALE * d).round.clamp(1, 30)
  end

  def self.penalty(from, to) = penalty_for([from], to)
end
