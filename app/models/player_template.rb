class PlayerTemplate < ApplicationRecord
  POSITIONS = Player::POSITIONS
  MAX_SECONDARY = Player::MAX_SECONDARY
  LEGACY_POSITIONS = Player::LEGACY_POSITIONS
  ATTRS = Player::ATTRS
  ATTR_LABELS = Player::ATTR_LABELS
  ATTR_SHORT = Player::ATTR_SHORT
  PROFILE = Player::PROFILE
  OVERALL_FORMULA = Player::OVERALL_FORMULA

  belongs_to :team
  belongs_to :source_player, class_name: "Player", optional: true, inverse_of: :base_template

  validates :name, presence: true
  validates :position, inclusion: { in: POSITIONS }
  validates :overall, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 15, less_than_or_equal_to: 45 }
  validates :stamina, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }
  validates(*ATTRS, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }, allow_nil: true)
  validate :alt_positions_ok

  def position
    value = self[:position].to_s.upcase
    LEGACY_POSITIONS.fetch(value, value)
  end

  def group = Positions::ALL[position][:group]

  def attr(name)
    value = self[name]
    return value if value
    return 40 if position == "GK"

    (overall + PROFILE.fetch(position)[ATTRS.index(name)]).clamp(15, 95)
  end

  def attrs_filled? = ATTRS.all? { |attribute| self[attribute] }

  def overall_from_attrs
    return nil if position == "GK" || !attrs_filled?

    values = ATTRS.map { |attribute| self[attribute] }
    calculate = lambda do |family|
      weights = OVERALL_FORMULA[family]
      weights[0] + values.each_with_index.sum { |value, index| weights[index + 1] * value }
    end
    family = { "DF" => "DEF", "MF" => "MID" }.fetch(group, "ATT")
    result = calculate.call(family)
    result = 0.5 * calculate.call("MID") + 0.5 * calculate.call("DEF") if position == "CDM"
    result.round.clamp(1, 99)
  end

  def raw_alts
    self[:alt_positions].to_s.split(",").map { |value| value.strip.upcase }.reject(&:blank?)
  end

  def secondary_positions = raw_alts.uniq - [position]
  def positions = [position] + secondary_positions
  def penalty_at(slot_position) = Positions.penalty_for(positions, slot_position)
  def rating_at(slot_position) = [overall - penalty_at(slot_position), 1].max

  def self.sync_to_players!
    transaction do
      find_each do |template|
        attributes = {
          team_id: template.team_id,
          name: template.name,
          position: template.position,
          overall: template.overall,
          alt_positions: template.alt_positions,
          age: template.age,
          stamina: template.stamina,
          fatigue: 0,
          starter: false,
          slot: nil,
          pace: template.pace,
          shooting: template.shooting,
          passing: template.passing,
          dribbling: template.dribbling,
          defending: template.defending,
          physical: template.physical
        }
        player = Player.find_by(id: template.source_player_id) if template.source_player_id

        if player
          player.update_columns(attributes.merge(updated_at: Time.current))
        else
          player = Player.create!(attributes)
          template.update_column(:source_player_id, player.id)
        end
      end
    end
  end

  def self.seed_age_for(team_name, player_name)
    @seed_ages ||= JSON.parse(Rails.root.join("db/player_ages_2026_27.json").read)
                     .fetch("ages")
                     .to_h { |entry| [[entry.fetch("team"), entry.fetch("player")], entry.fetch("age")] }
    @seed_ages.fetch([team_name, player_name], 25)
  end

  def self.seed_photo_url_for(team_name, player_name)
    @seed_photo_urls ||= JSON.parse(Rails.root.join("db/player_ages_2026_27.json").read)
                           .fetch("portraits", [])
                           .to_h { |entry| [[entry.fetch("team"), entry.fetch("player")], entry.fetch("photo_url")] }
    @seed_photo_urls[[team_name, player_name]]
  end

  private

  def alt_positions_ok
    invalid = raw_alts - POSITIONS
    errors.add(:alt_positions, "inválidas: #{invalid.join(', ')}") if invalid.any?
    errors.add(:alt_positions, "no máximo #{MAX_SECONDARY} posições secundárias") if secondary_positions.size > MAX_SECONDARY
    if position == "GK" && secondary_positions.any?
      errors.add(:alt_positions, "goleiro não tem posição secundária")
    elsif position != "GK" && secondary_positions.include?("GK")
      errors.add(:alt_positions, "só goleiro joga no gol")
    end
  end
end