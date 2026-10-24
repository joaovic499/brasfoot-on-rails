class AddStaminaFieldsToPlayers < ActiveRecord::Migration[8.1]
  def change
    add_column :players, :age, :integer, null: false, default: 25
    add_column :players, :stamina, :integer, null: false, default: 80
    add_column :players, :fatigue, :integer, null: false, default: 0
  end
end
