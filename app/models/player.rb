class Player < ApplicationRecord
  POSITIONS = Positions::ORDER
  MAX_SECONDARY = 2
  LEGACY_POSITIONS = { "DF" => "CB", "MF" => "CM", "FW" => "ST" }.freeze

  belongs_to :team
  has_many :player_match_stats, dependent: :delete_all
  validates :name, presence: true
  validates :position, inclusion: { in: POSITIONS }
  validates :overall, numericality: { only_integer: true, in: 1..99 }
  validate :alt_positions_ok

  # Tolera posições antigas (DF/MF/FW) ou em minúsculas vindas de times cadastrados à mão
  def position
    v = self[:position].to_s.upcase
    LEGACY_POSITIONS.fetch(v, v)
  end

  def position_name = Positions::ALL[position][:name]
  def group = Positions::ALL[position][:group]

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
