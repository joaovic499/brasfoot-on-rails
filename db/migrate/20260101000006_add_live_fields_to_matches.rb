class AddLiveFieldsToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :status, :string, default: "scheduled", null: false # scheduled, live, halftime, finished
    add_column :matches, :minute, :integer, default: 0, null: false
    add_column :matches, :subs_home, :integer, default: 0, null: false
    add_column :matches, :subs_away, :integer, default: 0, null: false
    add_column :matches, :subbed_off, :text
  end
end
