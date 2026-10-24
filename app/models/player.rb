class Player < ApplicationRecord
  POSITIONS = Positions::ORDER
  MAX_SECONDARY = 2
  LEGACY_POSITIONS = { "DF" => "CB", "MF" => "CM", "FW" => "ST" }.freeze

  # Os seis atributos principais (estilo cartão FIFA)
  ATTRS = %i[pace shooting passing dribbling defending physical].freeze
  ATTR_LABELS = { pace: "Ritmo", shooting: "Finalização", passing: "Passe",
                  dribbling: "Condução", defending: "Defesa", physical: "Físico" }.freeze
  ATTR_SHORT = { pace: "RIT", shooting: "FIN", passing: "PAS", dribbling: "CON", defending: "DEF", physical: "FIS" }.freeze

  # Perfil médio por posição (diferença dos atributos em relação à força), tirado dos dados reais
  # do FC 27 (ritmo, finalização, passe, condução, defesa, físico). Usado quando o jogador não tem atributos.
  PROFILE = {
    "CB" => [-10, -30, -12, -12, 0, -1], "LB" => [2, -19, -5, -3, -4, -5], "RB" => [2, -19, -5, -3, -4, -5],
    "CDM" => [-14, -12, -5, -6, -2, -3], "CM" => [-10, -9, -1, 0, -8, -7], "CAM" => [-9, -3, -2, 1, -22, -13],
    "LM" => [3, -6, -4, 1, -28, -14], "RM" => [3, -6, -4, 1, -28, -14],
    "LW" => [4, -3, -4, 1, -38, -15], "RW" => [4, -3, -4, 1, -38, -15], "ST" => [-2, 0, -9, -1, -38, -7]
  }.freeze

  # Força calculada a partir dos atributos (regressão nos dados reais: erro médio de ~1 ponto).
  # [constante, ritmo, finalização, passe, condução, defesa, físico]
  OVERALL_FORMULA = {
    "DEF" => [1.31, 0.07, -0.04, 0.10, 0.19, 0.65, 0.05],
    "MID" => [-5.85, 0.06, 0.15, 0.33, 0.41, 0.04, 0.14],
    "ATT" => [8.81, 0.06, 0.46, 0.05, 0.33, -0.04, 0.03]
  }.freeze

  belongs_to :team
  has_many :player_match_stats, dependent: :delete_all
  validates :name, presence: true
  validates :position, inclusion: { in: POSITIONS }
  validates :overall, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }
  validates(*ATTRS, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }, allow_nil: true)
  validate :alt_positions_ok

  # Tolera posições antigas (DF/MF/FW) ou em minúsculas vindas de times cadastrados à mão
  def position
    v = self[:position].to_s.upcase
    LEGACY_POSITIONS.fetch(v, v)
  end

  def position_name = Positions::ALL[position][:name]
  def group = Positions::ALL[position][:group]

  # ---------- atributos ----------
  # Valor do atributo; se não estiver preenchido, usa o perfil médio da posição
  def attr(name)
    v = self[name]
    return v if v
    return 40 if position == "GK"
    (overall + PROFILE.fetch(position)[ATTRS.index(name)]).clamp(15, 95)
  end

  def attrs_filled? = ATTRS.all? { |a| self[a] }

  # Quem finaliza bem faz gols
  def finishing = attr(:shooting)

  # Quem passa e conduz bem (e tem velocidade) dá assistências
  def creativity = 0.60 * attr(:passing) + 0.25 * attr(:dribbling) + 0.15 * attr(:pace)

  # Quem tem defesa/físico alto é mais "bruto": toma mais cartões
  def aggression = 0.5 * attr(:defending) + 0.5 * attr(:physical)

  # Força calculada pelos atributos (nil para goleiro ou se faltar atributo)
  def overall_from_attrs
    return nil if position == "GK" || !attrs_filled?
    vals = ATTRS.map { |a| self[a] }
    calc = lambda do |fam|
      w = OVERALL_FORMULA[fam]
      w[0] + vals.each_with_index.sum { |v, i| w[i + 1] * v }
    end
    fam = { "DF" => "DEF", "MF" => "MID" }.fetch(group, "ATT")
    v = calc.call(fam)
    v = 0.5 * calc.call("MID") + 0.5 * calc.call("DEF") if position == "CDM" # volante: meio + defesa
    v.round.clamp(1, 99)
  end

  # ---------- posições ----------
  def raw_alts
    self[:alt_positions].to_s.split(",").map { |x| x.strip.upcase }.reject(&:blank?)
  end

  # Posições secundárias (sem repetir a principal)
  def secondary_positions = raw_alts.uniq - [position]

  # Principal + secundárias
  def positions = [position] + secondary_positions

  # Quanto perde de força jogando em slot_pos (0 nas posições dele)
  def penalty_at(slot_pos) = Positions.penalty_for(positions, slot_pos)

  # Força efetiva jogando em slot_pos
  def rating_at(slot_pos) = [overall - penalty_at(slot_pos), 1].max

  private

  def alt_positions_ok
    bad = raw_alts - POSITIONS
    errors.add(:alt_positions, "inválidas: #{bad.join(', ')}") if bad.any?
    errors.add(:alt_positions, "no máximo #{MAX_SECONDARY} posições secundárias") if secondary_positions.size > MAX_SECONDARY
    if position == "GK" && secondary_positions.any?
      errors.add(:alt_positions, "goleiro não tem posição secundária")
    elsif position != "GK" && secondary_positions.include?("GK")
      errors.add(:alt_positions, "só goleiro joga no gol")
    end
  end
end
