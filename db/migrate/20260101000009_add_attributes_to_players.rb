class AddAttributesToPlayers < ActiveRecord::Migration[7.1]
  def change
    # Atributos principais (1 a 99). Nulo = usa o perfil médio da posição. Goleiros não usam.
    add_column :players, :pace, :integer       # ritmo
    add_column :players, :shooting, :integer   # finalização
    add_column :players, :passing, :integer    # passe
    add_column :players, :dribbling, :integer  # condução
    add_column :players, :defending, :integer  # defesa
    add_column :players, :physical, :integer   # físico
  end
end
