# [nome, posição principal, força, [posições secundárias (até 2)]]
# Posições: GK CB LB RB CDM CM LM RM CAM LW RW ST
SQUADS = {
  "Barcelona" => {
    short: "BAR", color: "#a50044", stadium: "Spotify Camp Nou",
    players: [
      ["Joan García", "GK", 82], ["Szczęsny", "GK", 82], ["Ter Stegen", "GK", 84],
      ["Cubarsí", "CB", 84], ["Araujo", "CB", 84, %w[RB]], ["Íñigo Martínez", "CB", 82], ["Eric García", "CB", 80, %w[RB CDM]],
      ["Koundé", "RB", 85, %w[CB]], ["Balde", "LB", 83, %w[LM]], ["Gerard Martín", "LB", 77],
      ["Casadó", "CDM", 79, %w[CM CB]],
      ["Pedri", "CM", 87, %w[CAM]], ["De Jong", "CM", 85, %w[CDM]], ["Gavi", "CM", 82, %w[CDM LM]], ["Bernal", "CM", 76, %w[CDM]],
      ["Olmo", "CAM", 83, %w[RW CM]], ["Fermín López", "CAM", 82, %w[CM RW]],
      ["Yamal", "RW", 90, %w[RM]], ["Raphinha", "LW", 87, %w[RW LM]], ["Rashford", "LW", 82, %w[ST LM]],
      ["Lewandowski", "ST", 86], ["Ferran Torres", "ST", 80, %w[RW LW]]
    ]
  },
  "Real Madrid" => {
    short: "RMA", color: "#e8e8e8", stadium: "Santiago Bernabéu",
    players: [
      ["Courtois", "GK", 89], ["Lunin", "GK", 79],
      ["Rüdiger", "CB", 85], ["Militão", "CB", 84, %w[RB]], ["Huijsen", "CB", 80], ["Alaba", "CB", 80, %w[LB CDM]], ["Asencio", "CB", 78],
      ["Trent Alexander-Arnold", "RB", 85, %w[RM]], ["Carvajal", "RB", 83, %w[CB]],
      ["Mendy", "LB", 80], ["Carreras", "LB", 79, %w[LM]],
      ["Tchouaméni", "CDM", 85, %w[CB CM]],
      ["Valverde", "CM", 88, %w[RM CDM]], ["Camavinga", "CM", 83, %w[CDM LB]], ["Ceballos", "CM", 78, %w[CDM]],
      ["Bellingham", "CAM", 90, %w[CM]], ["Arda Güler", "CAM", 82, %w[RW CM]], ["Brahim Díaz", "CAM", 80, %w[LW RW]],
      ["Vini Jr", "LW", 89, %w[LM ST]], ["Rodrygo", "RW", 85, %w[ST LW]], ["Mastantuono", "RW", 78, %w[CAM]],
      ["Mbappé", "ST", 90, %w[LW]], ["Endrick", "ST", 78]
    ]
  },
  "Atlético de Madrid" => {
    short: "ATM", color: "#cb3524", stadium: "Metropolitano",
    players: [
      ["Oblak", "GK", 87], ["Musso", "GK", 79],
      ["Giménez", "CB", 82, %w[RB]], ["Le Normand", "CB", 82], ["Hancko", "CB", 78, %w[LB]],
      ["Molina", "RB", 80, %w[RM]], ["Pubill", "RB", 76, %w[CB]],
      ["Reinildo", "LB", 79, %w[CB]], ["Ruggeri", "LB", 78, %w[CB LM]],
      ["Barrios", "CDM", 81, %w[CM]],
      ["Koke", "CM", 82, %w[CDM]], ["De Paul", "CM", 83, %w[RM CAM]], ["Gallagher", "CM", 80, %w[CDM CAM]],
      ["Marcos Llorente", "RM", 82, %w[RB CM]],
      ["Baena", "CAM", 80, %w[LW CM]],
      ["Giuliano Simeone", "RW", 79, %w[RM RB]], ["Lookman", "LW", 83, %w[ST RW]],
      ["Julián Álvarez", "ST", 87, %w[RW CAM]], ["Griezmann", "ST", 86, %w[CAM LW]], ["Sørloth", "ST", 80],
      ["Raspadori", "ST", 78, %w[CAM LW]]
    ]
  }
}.freeze

Career.destroy_all
Match.destroy_all
# Só recria os 3 times abaixo; os outros times que você cadastrou ficam intactos.
Team.where(name: SQUADS.keys).destroy_all

SQUADS.each do |name, data|
  team = Team.create!(name: name, short_name: data[:short], color: data[:color], stadium: data[:stadium])
  data[:players].each do |pname, pos, ovr, alts|
    team.players.create!(name: pname, position: pos, overall: ovr, alt_positions: (alts || []).join(","))
  end
  team.auto_lineup!("4-3-3")
end

puts "Seed ok: #{Team.count} times, #{Player.count} jogadores. O calendário é criado ao escolher seu time."
