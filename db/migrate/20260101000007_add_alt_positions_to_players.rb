class AddAltPositionsToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :alt_positions, :string, default: "", null: false # ex.: "LW,RW"
  end
end
