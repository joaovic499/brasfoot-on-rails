class CreatePlayerTemplates < ActiveRecord::Migration[8.1]
  def up
    create_table :player_templates do |t|
      t.references :team, null: false, foreign_key: true
      t.integer :source_player_id
      t.string :name, null: false
      t.string :position, null: false
      t.integer :overall, null: false
      t.string :alt_positions, default: "", null: false
      t.integer :age, default: 25, null: false
      t.integer :stamina, default: 80, null: false
      t.integer :pace
      t.integer :shooting
      t.integer :passing
      t.integer :dribbling
      t.integer :defending
      t.integer :physical
      t.timestamps
    end
    add_index :player_templates, :source_player_id, unique: true

    execute <<~SQL
      INSERT INTO player_templates (
        team_id, source_player_id, name, position, overall, alt_positions, age, stamina,
        pace, shooting, passing, dribbling, defending, physical, created_at, updated_at
      )
      SELECT
        team_id, id, name, position, overall, alt_positions, age, stamina,
        pace, shooting, passing, dribbling, defending, physical, created_at, updated_at
      FROM players
    SQL
  end

  def down
    drop_table :player_templates
  end
end