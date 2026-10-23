class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :short_name, null: false
      t.string :color, default: "#333333"
      t.string :stadium
      t.timestamps
    end
  end
end
