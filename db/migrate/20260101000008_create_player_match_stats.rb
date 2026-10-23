class CreatePlayerMatchStats < ActiveRecord::Migration[7.1]
  def change
    create_table :player_match_stats do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :team_id, null: false, index: true
      t.integer :goals, default: 0, null: false
      t.integer :assists, default: 0, null: false
      t.integer :yellow_cards, default: 0, null: false
      t.integer :red_cards, default: 0, null: false
      t.integer :minutes, default: 0, null: false
      t.float :rating, default: 6.0, null: false
      t.timestamps
    end
    add_index :player_match_stats, %i[match_id player_id], unique: true
    add_column :matches, :starting_ids, :text # titulares de cada time no apito inicial (JSON)
  end
end
