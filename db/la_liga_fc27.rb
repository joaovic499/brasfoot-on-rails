# La Liga 2026/27 — elencos e forças do EA SPORTS FC 27 (ratings de lançamento).
#
# Formato: [nome, posição principal, força, [posições secundárias (até 2)] ou nil, [ritmo, finalização, passe, condução, defesa, físico]]
# Goleiros não têm atributos. Atributos reais do FC 27 para ~110 jogadores (estrelas e titulares);
# os demais foram ESTIMADOS pelo perfil da posição (edite à vontade no editor de jogadores).
# Posições: GK CB LB RB CDM CM LM RM CAM LW RW ST
#
# Como usar:
#   bin/rails runner db/la_liga_fc27.rb                # recria só estes 20 times (os outros ficam intactos)
#   WIPE_ALL=1 bin/rails runner db/la_liga_fc27.rb     # apaga TODOS os times antes (começa do zero)
#
# Atenção: reinicia a temporada (apaga a carreira e as partidas), porque os elencos mudam.
SQUADS = {
  "Barcelona" => {
    short: "BAR", color: "#a50044", stadium: "Spotify Camp Nou",
    players: [
      ["Yamal", "RW", 90, %w[RM], [86, 84, 87, 93, 38, 61]], ["Rodri", "CDM", 90, %w[CM], [62, 78, 86, 81, 85, 81]], ["Pedri", "CM", 90, %w[CDM CAM], [76, 75, 89, 91, 77, 75]],
      ["Raphinha", "LW", 88, %w[RW CAM], [91, 86, 85, 87, 54, 76]], ["Cubarsí", "CB", 86, nil, [78, 44, 69, 77, 85, 81]], ["Joan García", "GK", 86],
      ["De Jong", "CM", 86, %w[CDM CAM], [77, 70, 85, 84, 77, 77]], ["Fermín López", "CAM", 85, %w[CM LM], [81, 84, 80, 84, 63, 72]], ["Eric García", "CB", 85, %w[RB CDM], [79, 58, 77, 76, 86, 82]],
      ["Koundé", "RB", 85, %w[CB RM], [82, 53, 74, 78, 83, 83]], ["Olmo", "CAM", 84, %w[CM LM], [74, 79, 82, 85, 51, 59]], ["João Cancelo", "LB", 83, %w[RB RM], [84, 72, 84, 85, 77, 72]],
      ["Gavi", "CM", 83, %w[CDM LM], [76, 66, 78, 85, 68, 70]], ["Anthony Gordon", "LW", 82, %w[ST LM], [91, 78, 77, 82, 50, 71]], ["Balde", "LB", 82, %w[LM], [90, 52, 75, 79, 77, 69]],
      ["Karim Adeyemi", "RM", 82, %w[LW CAM], [95, 80, 72, 82, 36, 69]], ["Szczęsny", "GK", 81], ["Gerard Martín", "CB", 79, %w[LB LM], [68, 36, 69, 64, 79, 80]],
      ["Andreas Christensen", "CB", 79, %w[CM CDM], [74, 46, 64, 70, 77, 75]], ["Marc Bernal", "CDM", 78, %w[CM], [72, 61, 75, 69, 75, 75]], ["Casadó", "CDM", 78, %w[CM], [56, 71, 70, 70, 78, 70]],
      ["Roony Bardghji", "RW", 74, %w[RM], [78, 71, 72, 75, 36, 58]], ["Héctor Fort", "RB", 72, %w[LB RM], [70, 62, 67, 71, 66, 68]], ["Xavi Espart", "RB", 67, %w[CDM CM], [67, 46, 60, 63, 62, 62]],
      ["Jesse Bisiwu", "LW", 67, %w[RW ST], [70, 61, 64, 68, 26, 56]], ["Álvaro Cortés", "CB", 66, nil, [57, 29, 46, 58, 68, 61]], ["Hamza Abdelkarim", "ST", 65, nil, [56, 65, 56, 66, 24, 63]]
    ]
  },
  "Real Madrid" => {
    short: "RMA", color: "#e8e8e8", stadium: "Santiago Bernabéu",
    players: [
      ["Mbappé", "ST", 91, %w[LW], [96, 91, 80, 92, 29, 76]], ["Courtois", "GK", 90], ["Bellingham", "CAM", 90, %w[CM LM], [79, 86, 83, 88, 79, 85]],
      ["Vini Jr", "LW", 89, %w[ST LM], [93, 85, 80, 91, 31, 71]], ["Valverde", "CM", 87, %w[RB RM], [90, 84, 83, 81, 81, 85]], ["Cucurella", "LB", 86, nil, [75, 64, 79, 78, 84, 78]],
      ["Trent Alexander-Arnold", "RB", 84, %w[RM], [75, 72, 89, 80, 77, 72]], ["Tchouaméni", "CDM", 84, %w[CM CB], [74, 70, 79, 77, 83, 82]], ["Yan Diomande", "RW", 84, %w[LW RM], [93, 77, 75, 87, 47, 70]],
      ["Militão", "CB", 84, nil, [79, 54, 71, 72, 85, 82]], ["Bernardo Silva", "CM", 84, %w[CDM RW], [50, 77, 84, 87, 71, 65]], ["Rodrygo", "LW", 84, %w[RW ST], [87, 77, 79, 87, 33, 63]],
      ["Konaté", "CB", 84, nil, [77, 34, 65, 68, 84, 85]], ["Dumfries", "RB", 83, %w[RM], [82, 70, 74, 79, 78, 87]], ["Rüdiger", "CB", 83, nil, [75, 54, 71, 69, 83, 85]],
      ["Arda Güler", "RM", 83, %w[CM CAM], [77, 79, 85, 84, 55, 57]], ["Camavinga", "CM", 81, %w[CDM LB], [79, 67, 80, 82, 78, 80]], ["Carreras", "LB", 81, %w[CB LM], [86, 66, 77, 80, 75, 81]],
      ["Huijsen", "CB", 81, nil, [72, 55, 72, 72, 82, 77]], ["Brahim Díaz", "RM", 81, %w[LM ST], [80, 73, 78, 84, 33, 63]], ["Mendy", "LB", 80, nil, [80, 62, 74, 75, 78, 81]],
      ["Lunin", "GK", 80], ["Endrick", "ST", 79, %w[RW CAM], [76, 79, 72, 77, 41, 73]], ["Asencio", "CB", 78, %w[RB], [71, 48, 70, 66, 80, 77]],
      ["Carlos Espí", "ST", 77, nil, [81, 77, 69, 75, 38, 71]], ["Thiago Pitarch", "CM", 70, %w[CDM CAM], [59, 56, 64, 66, 63, 66]]
    ]
  },
  "Atlético de Madrid" => {
    short: "ATM", color: "#cb3524", stadium: "Metropolitano",
    players: [
      ["Oblak", "GK", 88], ["Julián Álvarez", "ST", 86, %w[CAM], [86, 86, 82, 87, 58, 77]], ["Marcos Llorente", "RB", 85, %w[RM CM], [91, 79, 80, 82, 79, 83]],
      ["Grimaldo", "LM", 85, %w[LB CAM], [73, 77, 87, 85, 72, 65]], ["Hjulmand", "CDM", 83, %w[CM], [70, 76, 78, 77, 80, 84]], ["Pablo Barrios", "CM", 83, %w[CDM], [80, 71, 78, 83, 75, 78]],
      ["Hancko", "CB", 83, %w[LB], [77, 67, 74, 75, 83, 84]], ["Baena", "LM", 83, %w[CM CAM], [78, 75, 83, 82, 66, 68]], ["Lookman", "ST", 83, %w[CAM LM], [86, 83, 73, 84, 32, 68]],
      ["Sørloth", "ST", 83, %w[RW RM], [75, 83, 71, 74, 37, 83]], ["Giuliano Simeone", "RM", 82, %w[RW LM], [92, 76, 75, 80, 57, 83]], ["Musso", "GK", 82],
      ["Cristian Romero", "CB", 82, nil, [64, 48, 62, 64, 83, 81]], ["Giménez", "CB", 82, nil, [68, 46, 60, 62, 83, 80]], ["Pubill", "CB", 81, %w[RB], [79, 56, 71, 74, 81, 82]],
      ["Koke", "CM", 81, %w[CDM], [50, 72, 84, 77, 76, 77]], ["Le Normand", "CB", 81, nil, [66, 31, 60, 63, 81, 80]], ["Johnny Cardoso", "CDM", 80, %w[CM], [74, 67, 75, 77, 79, 78]],
      ["Lee Kang In", "RW", 80, %w[CAM RM], [72, 76, 81, 83, 52, 63]], ["Thomas Lemar", "CM", 77, %w[CAM LM], [68, 70, 75, 77, 73, 74]], ["Obed Vargas", "CDM", 72, %w[CM LM], [65, 58, 69, 65, 69, 70]],
      ["Rodri Mendoza", "CM", 71, %w[CAM], [59, 58, 68, 75, 61, 56]], ["Carlos Martín", "LW", 70, %w[RW ST], [73, 66, 65, 68, 31, 55]], ["Arnau Ortiz", "LM", 69, %w[LW], [68, 60, 60, 66, 30, 54]],
      ["Aleksa Purić", "CB", 67, nil, [45, 34, 46, 60, 65, 65]], ["Javi Boñar", "RB", 65, %w[CB], [67, 42, 57, 64, 58, 60]]
    ]
  },
  "Athletic Club" => {
    short: "ATH", color: "#c8102e", stadium: "San Mamés",
    players: [
      ["Unai Simón", "GK", 85], ["Nico Williams", "LW", 84, %w[LM], [93, 77, 79, 86, 37, 67]], ["Aymeric Laporte", "CB", 84, nil, [53, 52, 76, 70, 85, 79]],
      ["Sancet", "CAM", 82, %w[CM ST], [75, 80, 80, 84, 69, 81]], ["Vivian", "CB", 82, %w[RB], [76, 50, 61, 68, 82, 83]], ["Iñaki Williams", "RW", 80, %w[ST RM], [92, 79, 74, 77, 47, 83]],
      ["Yeray", "CB", 80, nil, [64, 49, 73, 66, 82, 75]], ["Jauregizar", "CM", 79, %w[CDM], [75, 72, 76, 77, 78, 80]], ["Yuri Berchiche", "LB", 79, %w[LM], [77, 68, 75, 74, 77, 81]],
      ["Berenguer", "RW", 79, %w[LM CAM], [81, 78, 77, 80, 67, 68]], ["Ruiz de Galarreta", "CDM", 79, %w[CM], [67, 65, 73, 76, 79, 75]], ["Guruzeta", "ST", 78, nil, [82, 82, 70, 80, 40, 72]],
      ["Aitor Paredes", "CB", 78, nil, [62, 53, 66, 63, 77, 78]], ["Beñat Prados", "CDM", 77, %w[CM CB], [72, 64, 71, 70, 73, 77]], ["Areso", "RB", 76, %w[RM], [74, 73, 70, 69, 70, 70]],
      ["Robert Navarro", "RW", 76, %w[RM LW], [79, 77, 69, 79, 45, 68]], ["Gorosabel", "RB", 76, nil, [73, 48, 69, 72, 67, 72]], ["Hugo Rincón", "RB", 75, %w[RM RW], [82, 56, 74, 70, 71, 66]],
      ["Álvaro Djaló", "RW", 74, %w[LW ST], [77, 74, 70, 72, 32, 53]], ["Peio Canales", "CAM", 73, %w[CM], [60, 67, 72, 75, 61, 53]], ["Adama Boiro", "LB", 73, %w[LM LW], [77, 65, 71, 70, 67, 60]],
      ["Rego", "CDM", 73, %w[CM], [63, 62, 71, 71, 69, 71]], ["Unai Vencedor", "CDM", 72, %w[CM], [65, 62, 63, 66, 72, 70]], ["Maroan", "ST", 71, nil, [66, 72, 61, 74, 29, 77]],
      ["Nico Serrano", "LW", 71, %w[LM RM], [71, 66, 64, 70, 26, 54]], ["Álex Padilla", "GK", 69]
    ]
  },
  "Osasuna" => {
    short: "OSA", color: "#d91a21", stadium: "El Sadar",
    players: [
      ["Ante Budimir", "ST", 82, nil, [65, 83, 63, 74, 36, 81]], ["Sergio Herrera", "GK", 79], ["Enzo Boyomo", "CB", 79, nil, [68, 53, 72, 70, 81, 78]],
      ["Valentin Rosier", "RB", 78, %w[RM RW], [76, 61, 72, 74, 77, 69]], ["Moncayola", "CM", 77, %w[CDM RM], [63, 70, 78, 74, 62, 73]], ["Aitor Fernández", "GK", 77],
      ["Rubén García", "RM", 77, %w[RW], [78, 72, 72, 75, 49, 65]], ["Catena", "CB", 77, nil, [66, 53, 67, 64, 76, 76]], ["Abel Bretones", "LB", 76, %w[LM LW], [76, 50, 72, 70, 73, 72]],
      ["Aimar Oroz", "CAM", 76, %w[CM LM], [69, 72, 73, 76, 55, 68]], ["Diego Rico", "LB", 76, %w[CB], [76, 60, 68, 73, 70, 73]], ["Moi Gómez", "CM", 76, %w[CDM], [56, 65, 74, 74, 69, 64]],
      ["Lucas Torró", "CDM", 76, %w[CM], [63, 64, 76, 69, 76, 73]], ["Raúl García", "ST", 75, %w[CAM], [77, 75, 70, 75, 26, 69]], ["Raúl Moro", "LW", 75, %w[LM RM], [86, 73, 75, 80, 22, 59]],
      ["Dubasin", "RW", 74, %w[LW ST], [75, 65, 68, 72, 42, 55]], ["Herrando", "CB", 74, nil, [60, 47, 62, 62, 72, 77]], ["Iker Muñoz", "CDM", 73, %w[CM], [68, 63, 68, 62, 69, 68]],
      ["Kike Barja", "LW", 73, %w[LM RW], [72, 68, 70, 76, 34, 64]], ["Osambela", "CB", 66, %w[CDM CM], [53, 41, 52, 54, 67, 66]], ["Rockson Yeboah", "CB", 65, nil, [51, 35, 52, 48, 66, 61]],
      ["Arguibide", "RB", 63, %w[RM RW], [65, 40, 61, 57, 57, 61]], ["Mauro Echegoyen", "CDM", 63, %w[CM], [49, 53, 58, 55, 61, 63]]
    ]
  },
  "Celta de Vigo" => {
    short: "CEL", color: "#8ac3ee", stadium: "Abanca Balaídos",
    players: [
      ["Iago Aspas", "RW", 81, %w[ST CAM], [72, 84, 81, 83, 37, 62]], ["Borja Iglesias", "ST", 80, nil, [62, 83, 71, 74, 40, 77]], ["Aleix Febas", "CM", 79, %w[CDM], [74, 68, 78, 82, 70, 71]],
      ["Marcos Alonso", "CB", 79, %w[LB], [54, 74, 81, 74, 80, 77]], ["Ilaix Moriba", "CM", 78, %w[CDM], [76, 72, 74, 78, 72, 74]], ["Ionuț Andrei Radu", "GK", 78],
      ["Carl Starfelt", "CB", 78, nil, [77, 52, 66, 64, 76, 77]], ["Javi Galán", "LB", 77, %w[LM], [74, 60, 73, 70, 70, 66]], ["Javi Rueda", "RB", 76, %w[RM RW], [83, 53, 71, 72, 76, 65]],
      ["Matías Vecino", "CM", 76, %w[CDM CAM], [75, 70, 77, 79, 67, 64]], ["Williot Swedberg", "LW", 76, %w[CM CAM], [83, 73, 71, 79, 35, 63]], ["Álvaro Núñez", "RB", 76, %w[RM CB], [74, 66, 69, 76, 72, 71]],
      ["Carreira", "RB", 76, %w[RM LM], [71, 61, 70, 71, 69, 76]], ["Javi Rodríguez", "CB", 76, %w[RB], [69, 44, 64, 63, 72, 80]], ["Hugo Álvarez", "LM", 75, %w[RM LW], [82, 66, 70, 74, 42, 61]],
      ["Altay Bayındır", "GK", 75], ["Ferran Jutglà", "ST", 75, %w[RW LW], [74, 72, 67, 73, 32, 70]], ["Miguel Román", "CM", 74, %w[CDM], [64, 64, 73, 76, 67, 66]],
      ["Pablo Durán", "ST", 74, %w[LW CAM], [79, 77, 65, 71, 29, 66]], ["Carles Pérez", "RM", 72, %w[LM RW], [84, 68, 73, 71, 51, 61]], ["Iván Villar", "GK", 72],
      ["Jones El-Abdellaoui", "RW", 72, %w[RM LM], [76, 63, 62, 73, 35, 57]], ["Abdoulaye Faye", "CB", 71, nil, [65, 40, 51, 61, 71, 72]], ["Yoel Lago", "CB", 71, nil, [52, 51, 57, 61, 70, 67]],
      ["Hugo González", "RM", 68, %w[RW LM], [73, 62, 63, 68, 46, 51]]
    ]
  },
  "Alavés" => {
    short: "ALA", color: "#0761af", stadium: "Mendizorrotza",
    players: [
      ["Toni Martínez", "ST", 78, nil, [71, 78, 64, 77, 33, 71]], ["Antonio Blanco", "CDM", 78, %w[CM], [68, 69, 73, 73, 76, 73]], ["Sivera", "GK", 77],
      ["Lucas Boyé", "ST", 77, %w[CAM], [68, 81, 66, 81, 35, 75]], ["Nahuel Tenaglia", "CB", 77, %w[RB], [76, 46, 68, 69, 79, 71]], ["Jonny", "RB", 76, %w[LB CB], [81, 48, 67, 77, 73, 75]],
      ["Denis Suárez", "CM", 74, %w[LM CDM], [65, 63, 76, 71, 67, 64]], ["Aleñá", "LM", 74, %w[CM RM], [75, 66, 68, 78, 59, 61]], ["Ander Guevara", "CDM", 74, %w[CM], [58, 64, 71, 67, 68, 70]],
      ["Abde Rebbach", "LW", 73, %w[LM LB], [79, 71, 69, 77, 28, 52]], ["Pablo Ibáñez", "CM", 73, %w[CDM], [63, 66, 67, 76, 66, 63]], ["Carlos Protesoni", "CDM", 73, %w[CM CB], [54, 60, 67, 68, 68, 71]],
      ["Nicolás Valentini", "CB", 73, nil, [62, 56, 54, 65, 75, 69]], ["Ángel Pérez", "RM", 72, %w[RB LM], [74, 67, 67, 71, 43, 49]], ["Miguel Rodríguez", "RW", 72, %w[RM], [71, 65, 65, 73, 36, 62]],
      ["Yusi", "LB", 70, %w[LM], [78, 49, 66, 66, 61, 67]], ["Adrián Rodríguez", "GK", 68], ["Ville Koski", "CB", 68, %w[CDM], [66, 36, 51, 54, 69, 64]],
      ["Mikel Rodríguez", "CM", 67, %w[CDM], [49, 58, 64, 69, 60, 57]], ["Mariano", "ST", 67, nil, [57, 71, 62, 63, 23, 65]], ["Owono", "GK", 67],
      ["Selu Diallo", "CM", 64, %w[CDM CAM], [57, 56, 66, 67, 54, 56]], ["Hugo Novoa", "RM", 64, %w[RB], [67, 56, 61, 64, 43, 49]], ["Aitor Mañas", "ST", 64, nil, [58, 66, 56, 62, 39, 60]],
      ["Xanet Oláiz", "CB", 63, %w[LB], [55, 36, 53, 52, 62, 63]], ["Tomás Mendes", "CM", 62, %w[CDM], [52, 57, 59, 65, 57, 64]]
    ]
  },
  "Elche" => {
    short: "ELC", color: "#1b8e3e", stadium: "Martínez Valero",
    players: [
      ["Valera", "LM", 76, %w[LB RM], [89, 70, 69, 77, 52, 54]], ["Matías Dituro", "GK", 76], ["David Affengruber", "CB", 76, nil, [65, 47, 57, 67, 79, 76]],
      ["Bigas", "CB", 76, nil, [69, 41, 69, 64, 78, 74]], ["Marc Aguado", "CDM", 74, %w[CM], [58, 63, 70, 67, 70, 72]], ["Víctor Chust", "CB", 74, nil, [56, 42, 60, 62, 78, 74]],
      ["Facundo Buonanotte", "CAM", 74, %w[RM CM], [54, 74, 71, 75, 47, 58]], ["Martim Neto", "CM", 72, %w[CDM CAM], [58, 61, 71, 71, 62, 69]], ["Josan", "RM", 72, %w[RB RW], [70, 65, 72, 74, 45, 48]],
      ["Gonzalo Villar", "CM", 72, %w[CAM CDM], [63, 66, 77, 75, 65, 64]], ["Ezequiel Ponce", "ST", 72, nil, [69, 76, 58, 73, 36, 68]], ["Fer Niño", "ST", 72, %w[CAM], [79, 72, 62, 70, 24, 64]],
      ["Lucas Cepeda", "LW", 71, %w[CM CAM], [73, 70, 72, 73, 37, 47]], ["Tete Morente", "LM", 71, %w[LW RM], [69, 62, 67, 71, 38, 53]], ["Federico Redondo", "CM", 70, %w[CDM], [63, 62, 68, 71, 60, 66]],
      ["Grady Diangana", "CAM", 70, %w[RM CM], [55, 72, 67, 72, 48, 53]], ["Yago Santiago", "LW", 70, %w[LM RM], [75, 69, 63, 70, 31, 49]], ["Buba Sangaré", "RB", 69, %w[CB RM], [73, 53, 65, 65, 64, 66]],
      ["John Donald", "CB", 69, %w[CDM CM], [56, 41, 47, 60, 73, 69]], ["Abiel Osorio", "ST", 68, %w[CAM], [57, 69, 65, 71, 33, 59]], ["Matia Barzić", "CB", 68, nil, [58, 50, 52, 55, 64, 65]],
      ["Bambo Diaby", "CB", 67, nil, [69, 35, 58, 58, 71, 68]], ["Iturbe", "GK", 66], ["Ali Houary", "CAM", 65, %w[CM], [50, 58, 67, 70, 33, 50]],
      ["Adam Boayar", "ST", 64, nil, [77, 64, 59, 60, 34, 62]], ["Álex Sánchez", "RM", 62, %w[LM CAM], [65, 55, 52, 60, 27, 47]]
    ]
  },
  "Getafe" => {
    short: "GET", color: "#005999", stadium: "Coliseum",
    players: [
      ["David Soria", "GK", 80], ["Martín Satriano", "ST", 77, %w[LW LM], [80, 77, 70, 76, 46, 72]], ["Dakonam Djené", "CB", 77, %w[RB CDM], [59, 53, 66, 63, 74, 79]],
      ["Zaid Romero", "CB", 77, %w[LB], [62, 49, 66, 65, 76, 80]], ["Johan Mojica", "LB", 76, %w[LM], [78, 61, 69, 68, 73, 71]], ["Borja Mayoral", "ST", 76, nil, [70, 73, 68, 77, 47, 76]],
      ["Christantus Uche", "ST", 75, %w[CAM CM], [69, 76, 66, 74, 34, 66]], ["Orel Mangala", "CDM", 75, %w[CM], [63, 68, 70, 68, 72, 72]], ["Enes Ünal", "ST", 75, nil, [66, 75, 64, 78, 40, 68]],
      ["Javi Muñoz", "CM", 74, %w[CAM RM], [75, 64, 69, 75, 65, 60]], ["Mario Martín", "CM", 74, %w[CDM CAM], [57, 61, 72, 75, 63, 66]], ["Terrats", "RM", 74, %w[CM CAM], [81, 67, 73, 75, 40, 59]],
      ["Sebastián Boselli", "CB", 74, %w[RB CDM], [67, 43, 60, 61, 74, 72]], ["Kiko Femenía", "RB", 74, %w[RM CDM], [72, 53, 68, 75, 73, 66]], ["Abdelkabir Abqar", "CB", 74, nil, [67, 42, 65, 65, 75, 68]],
      ["Yvan Neyou", "CM", 73, %w[CDM], [62, 67, 72, 68, 63, 68]], ["Andrés García", "RB", 73, %w[RM], [78, 41, 71, 67, 64, 72]], ["Álex Sancris", "RM", 73, %w[LM RW], [75, 68, 70, 73, 35, 60]],
      ["Saba Sazonov", "CB", 73, nil, [51, 33, 58, 57, 68, 72]], ["Francho Serrano", "CM", 72, %w[RM RB], [56, 65, 71, 70, 59, 68]], ["Juanmi", "ST", 71, %w[LM LW], [63, 73, 63, 70, 41, 61]],
      ["Jiří Letáček", "GK", 69], ["Davinchi", "LB", 69, %w[LM], [66, 47, 67, 66, 66, 60]], ["Berrocal", "CB", 69, nil, [44, 41, 61, 58, 66, 65]],
      ["Jean Ives Valou", "CB", 66, %w[LB], [47, 26, 50, 50, 67, 65]], ["Ismael Bekhoucha", "RB", 64, nil, [70, 42, 59, 61, 57, 56]]
    ]
  },
  "Levante" => {
    short: "LEV", color: "#b4053f", stadium: "Ciutat de València",
    players: [
      ["Mathew Ryan", "GK", 79], ["Aïssa Mandi", "CB", 79, %w[RB], [55, 46, 71, 68, 80, 75]], ["Carlos Álvarez", "RM", 77, %w[CAM RW], [76, 73, 75, 81, 40, 58]],
      ["Manu Sánchez", "LB", 76, nil, [78, 45, 67, 70, 72, 67]], ["Iván Romero", "ST", 75, %w[LM LW], [84, 73, 65, 78, 44, 68]], ["Karl Etta Eyong", "ST", 75, nil, [77, 74, 61, 70, 45, 76]],
      ["Hugo Sotelo", "CM", 74, %w[CDM], [67, 66, 76, 73, 68, 66]], ["Jeremy Toljan", "RB", 74, %w[RM], [84, 53, 69, 71, 67, 71]], ["Dela", "CB", 74, %w[RB], [68, 63, 70, 64, 74, 76]],
      ["Olasagasti", "CM", 74, %w[CDM LM], [59, 65, 74, 71, 70, 73]], ["Brugui", "ST", 74, %w[LM RM], [86, 70, 64, 75, 43, 69]], ["Thiago Fernández", "LM", 74, %w[LW], [83, 67, 68, 78, 52, 55]],
      ["Oriol Rey", "CM", 73, %w[CDM CB], [54, 61, 72, 72, 70, 74]], ["Enzo Bardeli", "CM", 73, %w[CAM LM], [69, 67, 72, 76, 54, 53]], ["Víctor García", "RM", 72, %w[RB], [77, 68, 69, 71, 58, 66]],
      ["Dani Requena", "CM", 70, %w[CAM CDM], [67, 62, 69, 74, 59, 70]], ["Kareem Tunde", "RM", 69, %w[LM RW], [82, 61, 62, 69, 51, 67]], ["Pablo Campos", "GK", 69],
      ["Paco Cortés", "LW", 68, %w[LM], [76, 60, 62, 73, 31, 44]], ["Tay Abed", "RW", 67, %w[RM], [78, 60, 61, 71, 44, 57]], ["Xavi Grande", "RB", 67, %w[RM RW], [73, 42, 63, 64, 64, 59]],
      ["Nacho Pérez", "RB", 67, nil, [78, 37, 59, 62, 62, 57]], ["Cabello", "CB", 67, %w[LB], [68, 39, 56, 54, 68, 69]], ["Dani Martín", "GK", 62],
      ["Martín Wilhelm Krug", "CB", 62, nil, [54, 30, 46, 50, 60, 68]], ["Ifeanyi Ndukwe", "CB", 61, nil, [68, 24, 48, 59, 59, 66]]
    ]
  },
  "Málaga" => {
    short: "MAL", color: "#0b5ea8", stadium: "La Rosaleda",
    players: [
      ["Pablo Martínez", "CM", 76, %w[LM CDM], [62, 64, 71, 76, 69, 66]], ["Chupe", "ST", 76, nil, [58, 73, 70, 80, 51, 69]], ["Alfonso Herrero", "GK", 75],
      ["Larrubia", "RW", 75, %w[RM], [75, 68, 71, 74, 26, 67]], ["Calero", "CB", 75, nil, [61, 39, 60, 62, 75, 73]], ["Dani Lorenzo", "CAM", 72, %w[CM ST], [62, 71, 73, 70, 40, 59]],
      ["Salinas", "LB", 72, %w[LM LW], [78, 56, 66, 69, 68, 65]], ["Adrián Niño", "ST", 72, %w[LW], [73, 67, 65, 74, 32, 61]], ["Murillo", "CB", 72, %w[RB CDM], [57, 46, 55, 63, 77, 71]],
      ["Puga", "RB", 71, %w[RM], [71, 61, 68, 68, 71, 60]], ["Joaquín Muñoz", "LW", 71, %w[LM], [76, 68, 66, 74, 37, 52]], ["Izan Merino", "CDM", 70, %w[CM], [56, 60, 70, 68, 66, 69]],
      ["Dotor", "CAM", 70, %w[CM ST], [60, 69, 74, 70, 43, 60]], ["Juan Cruz", "RM", 70, %w[CAM LM], [73, 66, 67, 71, 32, 53]], ["Einar Galilea", "CB", 69, nil, [59, 42, 60, 59, 70, 69]],
      ["Rafa Rodríguez", "CAM", 68, %w[ST CM], [60, 66, 60, 70, 37, 55]], ["Rafita", "RB", 68, %w[LB RM], [67, 51, 62, 70, 63, 68]], ["Jauregi", "ST", 68, nil, [73, 70, 66, 66, 27, 60]],
      ["Álex Pastor", "CB", 67, nil, [56, 32, 48, 53, 68, 64]], ["Aarón Ochoa", "LM", 66, %w[CAM ST], [63, 59, 62, 68, 40, 59]], ["Lobete", "LW", 66, %w[ST RW], [65, 67, 61, 70, 35, 61]],
      ["Dani Sánchez", "LB", 65, %w[LM], [64, 46, 59, 62, 61, 55]], ["Ramón Enríquez", "CM", 65, %w[CDM], [52, 54, 65, 62, 56, 54]], ["Ángel Recio", "CB", 65, nil, [57, 36, 40, 52, 64, 63]],
      ["Haitam Abaida", "RW", 63, %w[LW RM], [66, 57, 60, 63, 27, 54]], ["Carlos López", "GK", 62]
    ]
  },
  "Racing de Santander" => {
    short: "RAC", color: "#00a651", stadium: "El Sardinero",
    players: [
      ["Sergio Canales", "RM", 78, %w[CAM LM], [74, 76, 77, 79, 61, 62]], ["Iván Martín", "CM", 77, %w[CDM CAM], [77, 67, 70, 74, 68, 73]], ["Iñigo Vicente", "LM", 77, %w[CAM LW], [79, 76, 74, 77, 43, 67]],
      ["Andrés Martín", "RW", 77, %w[RM], [91, 71, 75, 78, 34, 63]], ["Agirrezabala", "GK", 76], ["Gustavo Puerta", "CDM", 74, %w[CM], [53, 70, 70, 71, 72, 75]],
      ["Villalibre", "ST", 74, nil, [61, 75, 63, 74, 42, 65]], ["Jorge Salinas", "LB", 72, %w[CB], [77, 55, 68, 71, 68, 67]], ["Mantilla", "RB", 71, %w[CDM], [65, 50, 71, 64, 69, 64]],
      ["Arana", "ST", 70, nil, [62, 67, 67, 68, 32, 64]], ["Pedro Felipe", "CB", 69, nil, [65, 44, 56, 54, 69, 66]], ["Simon Eriksson", "GK", 69],
      ["Giorgi Guliashvili", "ST", 69, nil, [65, 70, 63, 66, 29, 69]], ["Maguette Gueye", "CDM", 69, %w[CM], [62, 59, 64, 64, 68, 64]], ["Pablo Ramón", "CB", 69, nil, [54, 38, 44, 58, 67, 71]],
      ["Manu Hernando", "CB", 69, nil, [55, 29, 51, 56, 70, 68]], ["Facundo González", "CB", 69, nil, [55, 41, 52, 60, 65, 68]], ["Íñigo Sainz-Maza", "CDM", 67, %w[CM], [59, 55, 65, 64, 61, 64]],
      ["Yassir Zabiri", "ST", 66, nil, [67, 62, 54, 65, 29, 64]], ["Sergio Martínez", "CDM", 64, %w[CM], [53, 49, 60, 61, 60, 64]], ["Aitor Crespo", "CB", 60, nil, [48, 37, 51, 47, 59, 57]],
      ["Laro Gómez", "GK", 60], ["Diego Díaz", "CAM", 59, %w[CM], [51, 54, 54, 62, 34, 42]]
    ]
  },
  "Rayo Vallecano" => {
    short: "RAY", color: "#e53027", stadium: "Estadio de Vallecas",
    players: [
      ["De Frutos", "RW", 81, %w[ST RM], [82, 81, 76, 81, 47, 72]], ["Álvaro García", "LW", 81, %w[LM ST], [88, 77, 78, 79, 51, 45]], ["Andrei Rațiu", "RB", 80, %w[RM RW], [94, 67, 74, 81, 74, 71]],
      ["Isi", "CAM", 80, %w[RM ST], [80, 77, 80, 82, 40, 65]], ["Augusto Batalla", "GK", 79], ["Florian Lejeune", "CB", 79, nil, [64, 52, 65, 62, 75, 79]],
      ["Pathé Ciss", "CDM", 77, %w[CM CB], [72, 66, 68, 70, 77, 75]], ["Óscar Valentín", "CDM", 77, %w[CM], [60, 67, 72, 69, 68, 77]], ["Unai López", "CM", 76, %w[CDM], [67, 73, 80, 79, 68, 68]],
      ["Pedro Díaz", "CM", 75, %w[CDM CAM], [55, 67, 75, 76, 71, 67]], ["Luiz Felipe", "CB", 75, nil, [61, 36, 60, 64, 78, 78]], ["Marash Kumbulla", "CB", 75, nil, [68, 36, 58, 60, 74, 72]],
      ["Iván Balliu", "RB", 74, %w[LB RM], [80, 52, 70, 74, 73, 69]], ["Dani Cárdenas", "GK", 74], ["Sergio Camello", "ST", 74, %w[CAM], [75, 76, 67, 74, 35, 65]],
      ["Alemão", "ST", 74, nil, [64, 72, 66, 68, 39, 67]], ["Fran Pérez", "RW", 74, %w[LW RM], [72, 70, 68, 74, 33, 57]], ["Giorgi Tsitaishvili", "LM", 74, %w[LB LW], [79, 69, 70, 73, 50, 55]],
      ["Raúl De Tomás", "ST", 72, nil, [70, 75, 58, 75, 35, 67]], ["Randy Nteka", "ST", 70, %w[CAM CM], [60, 73, 62, 74, 27, 66]], ["Jozhua Vertrouwd", "CB", 68, %w[LB LM], [58, 46, 59, 52, 68, 69]],
      ["Miguel Morro", "GK", 65], ["Diego Méndez", "CDM", 64, %w[CM], [44, 50, 60, 52, 58, 58]], ["Pelayo Fernández", "CB", 64, nil, [55, 35, 55, 54, 66, 60]],
      ["Etienne Eto'o", "ST", 63, %w[CAM], [56, 57, 53, 57, 30, 60]], ["Samu Becerra", "CM", 61, %w[CAM RM], [64, 53, 60, 62, 57, 56]]
    ]
  },
  "Deportivo de La Coruña" => {
    short: "DEP", color: "#0a3a8c", stadium: "Riazor",
    players: [
      ["Pierre-Emerick Aubameyang", "ST", 79, nil, [75, 78, 71, 79, 35, 65]], ["Angeliño", "LB", 78, %w[LM], [87, 56, 70, 79, 76, 71]], ["Leo Román", "GK", 77],
      ["Yeremay", "LM", 77, %w[ST CAM], [78, 66, 69, 81, 46, 68]], ["Mario Soriano", "CAM", 75, %w[CM ST], [80, 69, 78, 77, 67, 70]], ["Álvaro Ferllo", "GK", 74],
      ["Luismi Cruz", "RW", 74, %w[CAM LW], [79, 71, 67, 76, 37, 63]], ["Villares", "CM", 73, %w[CDM], [63, 68, 75, 72, 70, 66]], ["Alti", "RB", 73, %w[RM RW], [68, 56, 68, 67, 70, 69]],
      ["Lorenzo Amatucci", "CM", 73, %w[CDM], [71, 65, 75, 77, 59, 62]], ["Giacomo Quagliata", "LB", 73, %w[LM LW], [73, 54, 64, 72, 70, 71]], ["Loureiro", "CB", 73, %w[RB CDM], [67, 30, 69, 61, 74, 72]],
      ["Mella", "RM", 73, %w[RB LM], [74, 67, 70, 72, 60, 59]], ["Lucas Noubi", "CB", 73, %w[RB CDM], [57, 47, 58, 64, 76, 76]], ["Ximo Navarro", "RB", 72, %w[CB], [81, 48, 68, 65, 68, 66]],
      ["Riki", "CM", 72, %w[CDM], [52, 64, 73, 77, 63, 61]], ["Zakaria Eddahchouri", "ST", 72, nil, [70, 69, 65, 72, 18, 62]], ["Dani Barcia", "CB", 71, nil, [59, 40, 60, 63, 72, 67]],
      ["Jonathan Asp-Jensen", "LW", 69, %w[CAM CM], [62, 68, 66, 75, 26, 55]], ["José Ángel", "CDM", 69, %w[CM], [51, 55, 64, 63, 63, 64]], ["Bil Nsongo", "ST", 69, nil, [73, 68, 56, 57, 38, 68]],
      ["Germán Parreño", "GK", 68], ["Arnau Comas", "CB", 68, nil, [69, 33, 58, 58, 67, 67]], ["Charlie Patiño", "CM", 67, %w[CDM CAM], [64, 58, 65, 66, 60, 60]],
      ["Bright Ede", "CB", 66, nil, [65, 40, 55, 48, 67, 66]], ["Jairo Noriega", "CAM", 64, %w[CM], [57, 66, 61, 62, 48, 48]]
    ]
  },
  "Espanyol" => {
    short: "ESP", color: "#007fc8", stadium: "RCDE Stadium",
    players: [
      ["Marko Dmitrović", "GK", 79], ["Edu Expósito", "CAM", 77, %w[CM CDM], [68, 72, 74, 80, 65, 55]], ["Puado", "LW", 77, %w[ST CAM], [78, 72, 72, 80, 43, 57]],
      ["Urko González", "CDM", 76, %w[CM], [59, 66, 75, 70, 76, 69]], ["Leandro Cabrera", "CB", 76, nil, [79, 48, 65, 65, 78, 75]], ["Cala", "CAM", 75, %w[ST RM], [55, 72, 77, 78, 63, 76]],
      ["Quilindschy Hartman", "LB", 75, nil, [81, 63, 70, 70, 69, 71]], ["Pere Milla", "LM", 75, %w[ST CAM], [80, 68, 72, 77, 47, 60]], ["Pol Lozano", "CDM", 75, %w[CM], [58, 61, 71, 65, 71, 73]],
      ["Omar El Hilali", "RB", 75, %w[CB CDM], [78, 66, 73, 71, 70, 66]], ["Kike García", "ST", 75, %w[CAM], [78, 71, 67, 69, 42, 73]], ["Unai Núñez", "CB", 75, %w[RB], [65, 42, 58, 65, 76, 71]],
      ["Roberto Fernández", "ST", 74, nil, [83, 67, 68, 78, 52, 55]], ["Tyrhys Dolan", "RW", 74, %w[RM LM], [89, 69, 70, 73, 31, 54]], ["Jofre", "RW", 73, %w[RM LM], [80, 74, 69, 76, 23, 52]],
      ["Javi Hernández", "RM", 73, %w[ST CAM], [74, 65, 72, 74, 58, 52]], ["Gabriel Moscardo", "CDM", 72, %w[CM CB], [58, 59, 67, 64, 71, 72]], ["Marcos Fernández", "ST", 72, nil, [84, 70, 65, 71, 33, 69]],
      ["Rubén Sánchez", "RB", 71, %w[RM RW], [76, 57, 65, 68, 65, 65]], ["Vanja Drkušić", "CB", 71, %w[RB], [66, 46, 55, 61, 71, 69]], ["Clemens Riedel", "CB", 70, %w[RB], [49, 44, 46, 56, 70, 68]],
      ["Rafa Bauza", "CDM", 68, %w[CM], [53, 59, 62, 59, 66, 66]], ["Roger Hinojo", "LB", 68, %w[CB CDM], [71, 53, 67, 66, 63, 59]], ["Fortuño", "GK", 65],
      ["Llorenç Serred", "GK", 62]
    ]
  },
  "Real Betis" => {
    short: "BET", color: "#00954c", stadium: "Benito Villamarín",
    players: [
      ["Isco", "CAM", 83, %w[CM CDM], [57, 78, 85, 86, 59, 60]], ["Fornals", "CM", 81, %w[CAM CDM], [66, 75, 83, 80, 74, 72]], ["Antony", "RW", 81, %w[RM], [85, 81, 79, 82, 48, 71]],
      ["Abde", "LW", 81, %w[LM], [89, 75, 73, 84, 37, 70]], ["Giovani Lo Celso", "CAM", 80, %w[CM CDM], [74, 77, 82, 81, 67, 68]], ["Cucho Hernández", "ST", 79, %w[CAM], [81, 78, 75, 81, 45, 78]],
      ["Bartra", "CB", 79, nil, [68, 59, 68, 67, 83, 76]], ["Diego Llorente", "CB", 79, nil, [60, 51, 73, 67, 78, 76]], ["Natan", "CB", 79, nil, [56, 55, 67, 70, 80, 78]],
      ["Marc Roca", "CDM", 78, %w[CM], [70, 67, 73, 69, 73, 76]], ["Troy Parrott", "ST", 78, %w[CAM], [78, 75, 72, 73, 34, 68]], ["Aitor Ruibal", "RM", 77, %w[RB LM], [73, 67, 74, 78, 46, 67]],
      ["Álvaro Valles", "GK", 77], ["Fran García", "LB", 77, %w[LM], [72, 63, 72, 76, 77, 71]], ["Fidalgo", "CM", 77, %w[CAM CDM], [59, 66, 75, 80, 64, 71]],
      ["Héctor Bellerín", "RB", 76, %w[RM], [87, 56, 67, 75, 69, 65]], ["Diego Conde", "GK", 76], ["Riquelme", "LM", 76, %w[CAM RM], [76, 66, 80, 73, 67, 61]],
      ["Valentín Gómez", "CB", 76, %w[LB], [61, 46, 68, 62, 76, 80]], ["Nelson Deossa", "CDM", 75, %w[CM CAM], [51, 60, 71, 73, 74, 71]], ["Junior Firpo", "LB", 74, %w[LM], [81, 58, 76, 74, 67, 68]],
      ["Facundo Bernal", "CDM", 74, %w[CM], [60, 62, 71, 70, 70, 71]], ["Iker Losada", "CAM", 72, %w[LM CM], [58, 70, 71, 73, 48, 65]], ["Pablo García", "RW", 70, %w[RM LM], [84, 66, 65, 71, 54, 56]],
      ["Ángel Ortiz", "RB", 70, nil, [75, 51, 68, 67, 64, 63]], ["Gonzalo Petit", "ST", 69, nil, [66, 70, 63, 65, 47, 63]]
    ]
  },
  "Real Sociedad" => {
    short: "RSO", color: "#0067b1", stadium: "Reale Arena",
    players: [
      ["Oyarzabal", "ST", 84, nil, [71, 86, 81, 84, 45, 74]], ["Álex Remiro", "GK", 81], ["Takefusa Kubo", "RM", 80, %w[RW], [85, 75, 76, 83, 43, 65]],
      ["Guedes", "LW", 80, %w[RM ST], [81, 82, 77, 78, 37, 68]], ["Carlos Soler", "CM", 79, %w[CAM CDM], [70, 76, 80, 78, 71, 70]], ["Barrenetxea", "LW", 79, %w[LM RM], [82, 80, 72, 77, 62, 57]],
      ["Yangel Herrera", "CM", 78, %w[CDM], [59, 68, 73, 75, 72, 62]], ["Sergio Gómez", "LB", 78, %w[LM CM], [81, 61, 68, 78, 73, 75]], ["Gorrotxa", "CDM", 78, %w[CM], [75, 67, 72, 65, 77, 75]],
      ["Jon Martín", "CB", 78, nil, [68, 52, 63, 63, 77, 76]], ["Zubeldia", "CB", 77, nil, [60, 60, 66, 64, 82, 74]], ["Jon Mikel Aramburu", "RB", 77, nil, [79, 61, 73, 76, 71, 70]],
      ["Luka Sučić", "CM", 76, %w[CAM ST], [64, 64, 74, 74, 70, 63]], ["Turrientes", "CDM", 76, %w[CM], [59, 66, 75, 68, 75, 71]], ["Unai Marrero", "GK", 74],
      ["Orri Óskarsson", "ST", 74, nil, [82, 69, 68, 77, 42, 69]], ["Pacheco", "CB", 74, %w[LB], [64, 49, 62, 59, 76, 71]], ["Pablo Marín", "CM", 73, %w[CDM LM], [71, 65, 71, 68, 61, 70]],
      ["Aihen Muñoz", "LB", 73, nil, [81, 51, 67, 70, 66, 68]], ["Odriozola", "RB", 73, nil, [76, 46, 71, 78, 71, 71]], ["Arsen Zakharyan", "RM", 73, %w[CM LM], [74, 67, 66, 72, 50, 61]],
      ["Mikel Goti", "CAM", 69, %w[CM RM], [45, 65, 69, 74, 54, 56]], ["Job Nguono Ochieng", "LM", 68, %w[RM LW], [77, 57, 68, 71, 38, 49]], ["Karrikaburu", "ST", 67, %w[CAM], [64, 68, 54, 70, 37, 65]]
    ]
  },
  "Sevilla" => {
    short: "SEV", color: "#d4021d", stadium: "Ramón Sánchez-Pizjuán",
    players: [
      ["Odysseas Vlachodimos", "GK", 79], ["Rubén Vargas", "LW", 78, %w[CAM RW], [79, 77, 74, 81, 37, 63]], ["Carmona", "RB", 77, %w[CB LB], [85, 56, 69, 74, 74, 76]],
      ["Lucien Agoumé", "CDM", 76, %w[CM CAM], [60, 62, 70, 68, 75, 71]], ["Chidera Ejuke", "LW", 76, %w[LM RM], [77, 75, 74, 75, 44, 58]], ["Juan Iglesias", "RB", 76, %w[LB RM], [68, 52, 76, 76, 74, 71]],
      ["Kike Salas", "CB", 76, %w[LB CDM], [59, 61, 69, 66, 79, 73]], ["Alfon", "LW", 75, %w[LM CAM], [78, 72, 73, 76, 40, 61]], ["Giorgi Kochorashvili", "CM", 74, %w[CDM CAM], [66, 63, 69, 73, 64, 70]],
      ["Adrià Pedrosa", "LB", 74, %w[LM LW], [74, 45, 65, 72, 67, 68]], ["Gabriel Suazo", "LB", 74, %w[LM LW], [71, 52, 69, 72, 69, 66]], ["Isaac Romero", "ST", 74, %w[CAM], [71, 76, 68, 72, 34, 68]],
      ["Peque", "CAM", 74, %w[LM ST], [60, 70, 71, 77, 40, 73]], ["Arouna Sangante", "CB", 74, %w[RB], [60, 40, 72, 58, 74, 68]], ["Oso", "LB", 73, %w[LM LW], [74, 55, 65, 69, 68, 72]],
      ["Guridi", "CM", 73, %w[CAM ST], [53, 71, 74, 78, 66, 66]], ["Marcão", "CB", 73, nil, [61, 43, 60, 61, 72, 73]], ["Andrés Castrín", "CB", 73, nil, [71, 33, 60, 59, 76, 74]],
      ["Fábio Cardoso", "CB", 73, nil, [62, 48, 57, 59, 73, 71]], ["Robbie Ure", "ST", 71, nil, [63, 70, 62, 65, 36, 68]], ["Julio Díaz", "LB", 68, %w[LM LW], [72, 50, 68, 65, 61, 63]],
      ["Manu Bueno", "CM", 67, %w[CAM CDM], [52, 54, 69, 71, 67, 65]], ["Miguel Sierra", "RW", 65, %w[LW RM], [71, 63, 57, 63, 18, 45]], ["Fran González", "GK", 65],
      ["Nico Guillén", "CM", 63, %w[CDM], [55, 58, 60, 63, 51, 60]], ["Rafa Romero", "GK", 62]
    ]
  },
  "Valencia" => {
    short: "VAL", color: "#f47b20", stadium: "Mestalla",
    players: [
      ["Guido Rodríguez", "CDM", 78, %w[CM], [55, 65, 74, 72, 78, 78]], ["Javi Guerra", "CM", 77, %w[CDM CAM], [65, 67, 76, 75, 74, 64]], ["Gayà", "LB", 77, %w[LM], [79, 57, 75, 70, 72, 73]],
      ["Maffeo", "RB", 77, nil, [77, 53, 70, 74, 72, 67]], ["Hugo Duro", "ST", 77, nil, [88, 81, 67, 76, 20, 67]], ["Luis Rioja", "RM", 77, %w[LM RW], [80, 67, 69, 77, 56, 60]],
      ["Stole Dimitrievski", "GK", 77], ["Diego López", "LW", 77, %w[RM ST], [76, 73, 69, 78, 33, 66]], ["Pepelu", "CM", 76, %w[CDM CB], [62, 68, 74, 76, 71, 73]],
      ["Umar Sadiq", "ST", 76, nil, [79, 76, 70, 75, 47, 70]], ["Mouctar Diakhaby", "CB", 76, nil, [67, 46, 63, 67, 77, 73]], ["Justin de Haas", "CB", 76, nil, [69, 60, 66, 58, 77, 78]],
      ["Filip Ugrinić", "CM", 75, %w[CDM CAM], [66, 68, 69, 75, 64, 67]], ["Arnaut Danjuma", "LW", 75, %w[ST LM], [79, 76, 69, 76, 43, 56]], ["César Tárrega", "CB", 75, nil, [61, 35, 64, 66, 71, 74]],
      ["André Almeida", "CAM", 74, %w[LM ST], [63, 70, 70, 76, 67, 60]], ["Dani Raba", "RW", 74, %w[ST CAM], [75, 72, 74, 79, 36, 65]], ["Copete", "CB", 74, nil, [60, 55, 59, 62, 78, 71]],
      ["Aliou Dieng", "CDM", 73, %w[CM], [51, 61, 66, 68, 72, 72]], ["Dimitri Foulquier", "RB", 72, %w[CB CDM], [79, 57, 59, 67, 66, 64]], ["Jesús Vázquez", "LB", 71, %w[LM], [74, 52, 64, 66, 66, 68]],
      ["Ryunosuke Sato", "LM", 71, %w[RM CM], [81, 60, 66, 73, 46, 58]], ["Sergi Canós", "LM", 68, %w[LW RM], [79, 59, 65, 70, 49, 51]], ["Cristian Rivero", "GK", 65],
      ["Iker Córdoba", "CB", 65, nil, [61, 28, 46, 56, 63, 66]], ["David Otorbi", "RW", 64, %w[RM LM], [65, 60, 60, 63, 22, 57]]
    ]
  },
  "Villarreal" => {
    short: "VIL", color: "#f5d90a", stadium: "Estadio de la Cerámica",
    players: [
      ["Péter Gulácsi", "GK", 82], ["Moleiro", "LM", 82, %w[CAM LW], [86, 76, 77, 84, 51, 68]], ["Gerard Moreno", "ST", 81, %w[RW CAM], [76, 82, 77, 80, 48, 73]],
      ["Nicolas Pépé", "RW", 81, %w[ST RM], [87, 80, 75, 84, 37, 69]], ["Carlos Romero", "LB", 80, %w[LM], [81, 75, 77, 80, 77, 74]], ["Pape Gueye", "CM", 80, %w[CDM], [72, 73, 75, 78, 78, 82]],
      ["Ayoze", "ST", 80, %w[LW CAM], [81, 81, 78, 81, 59, 66]], ["Sergi Cardona", "LB", 79, %w[LM], [82, 56, 75, 76, 75, 75]], ["Santi Comesaña", "CM", 79, %w[CDM], [57, 70, 80, 82, 65, 72]],
      ["Georges Mikautadze", "ST", 79, nil, [78, 78, 73, 78, 45, 73]], ["Juan Foyth", "CB", 79, %w[RB], [72, 44, 64, 69, 81, 81]], ["Renato Veiga", "CB", 78, nil, [67, 37, 68, 73, 75, 79]],
      ["Santiago Mouriño", "RB", 78, %w[CB], [82, 65, 72, 73, 71, 68]], ["Luiz Júnior", "GK", 78], ["Tajon Buchanan", "RM", 76, %w[RW], [86, 73, 73, 75, 46, 62]],
      ["Logan Costa", "CB", 76, nil, [69, 39, 61, 66, 74, 74]], ["Ilias Akhomach", "RW", 75, %w[RM], [78, 73, 69, 78, 36, 53]], ["Pau Navarro", "CB", 74, %w[RB CM], [60, 38, 66, 68, 77, 72]],
      ["Alex Freeman", "RB", 73, %w[CM], [75, 52, 69, 69, 69, 70]], ["Willy Kambwala", "CB", 72, nil, [60, 49, 57, 62, 75, 67]], ["Tani Oluwaseyi", "ST", 71, %w[RM], [64, 68, 64, 71, 29, 60]],
      ["Carlos Macià", "CM", 65, %w[CDM], [58, 60, 67, 65, 52, 59]], ["Rubén Gómez", "GK", 63], ["Alassane Diatta", "CDM", 62, %w[CM], [51, 50, 58, 57, 62, 63]]
    ]
  }
}.freeze

ActiveRecord::Base.transaction do
  Career.destroy_all
  Match.destroy_all
  if ENV["WIPE_ALL"].present?
    Team.destroy_all
  else
    Team.where(name: SQUADS.keys).destroy_all
  end

  SQUADS.each do |name, data|
    team = Team.create!(name: name, short_name: data[:short], color: data[:color], stadium: data[:stadium])
    data[:players].each do |pname, pos, ovr, alts, at|
      age = PlayerTemplate.seed_age_for(name, pname)
      player = team.players.create!(name: pname, position: pos, overall: ovr, age: age,
                                    alt_positions: (alts || []).join(","), pace: at&.[](0),
                                    shooting: at&.[](1), passing: at&.[](2), dribbling: at&.[](3),
                                    defending: at&.[](4), physical: at&.[](5))
      PlayerTemplate.create!(team: team, source_player_id: player.id, name: player.name,
                             position: player.position, overall: player.overall,
                             alt_positions: player.alt_positions, age: age, stamina: player.stamina,
                             photo_url: PlayerTemplate.seed_photo_url_for(name, pname),
                             pace: player.pace, shooting: player.shooting, passing: player.passing,
                             dribbling: player.dribbling, defending: player.defending, physical: player.physical)
    end
    team.auto_lineup!("4-3-3")
  end
end

puts "Pronto: #{Team.count} times, #{Player.count} jogadores. O calendário é criado ao escolher seu time."
