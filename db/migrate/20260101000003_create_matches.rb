class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.integer :home_team_id, null: false
      t.integer :away_team_id, null: false
      t.integer :round, null: false
      t.integer :home_goals
      t.integer :away_goals
      t.boolean :played, default: false, null: false
      t.text :events
      t.timestamps
    end
  end
end
