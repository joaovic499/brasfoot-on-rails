class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name, null: false
      t.string :position, null: false # GK DF MF FW
      t.integer :overall, null: false
      t.boolean :starter, default: false, null: false
      t.timestamps
    end
  end
end
