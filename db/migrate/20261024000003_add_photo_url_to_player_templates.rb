class AddPhotoUrlToPlayerTemplates < ActiveRecord::Migration[8.1]
  def change
    add_column :player_templates, :photo_url, :string
  end
end
