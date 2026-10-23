class AddLineupFields < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :formation, :string, default: "4-3-3", null: false
    add_column :players, :slot, :integer
  end
end
