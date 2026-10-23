# La Liga 2026/27 — elencos e forças do EA SPORTS FC 27 (ratings de lançamento).
#
# Formato: [nome, posição principal, força, [posições secundárias (até 2)]]
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
      ["Yamal", "RW", 90, %w[RM]], ["Rodri", "CDM", 90, %w[CM]], ["Pedri", "CM", 90, %w[CDM CAM]],
      ["Raphinha", "LW", 88, %w[RW CAM]], ["Cubarsí", "CB", 86], ["Joan García", "GK", 86],
      ["De Jong", "CM", 86, %w[CDM CAM]], ["Fermín López", "CAM", 85, %w[CM LM]], ["Eric García", "CB", 85, %w[RB CDM]],
      ["Koundé", "RB", 85, %w[CB RM]], ["Olmo", "CAM", 84, %w[CM LM]], ["João Cancelo", "LB", 83, %w[RB RM]],
      ["Gavi", "CM", 83, %w[CDM LM]], ["Anthony Gordon", "LW", 82, %w[ST LM]], ["Balde", "LB", 82, %w[LM]],
      ["Karim Adeyemi", "RM", 82, %w[LW CAM]], ["Szczęsny", "GK", 81], ["Gerard Martín", "CB", 79, %w[LB LM]],
      ["Andreas Christensen", "CB", 79, %w[CM CDM]], ["Marc Bernal", "CDM", 78, %w[CM]], ["Casadó", "CDM", 78, %w[CM]],
      ["Roony Bardghji", "RW", 74, %w[RM]], ["Héctor Fort", "RB", 72, %w[LB RM]], ["Xavi Espart", "RB", 67, %w[CDM CM]],
      ["Jesse Bisiwu", "LW", 67, %w[RW ST]], ["Álvaro Cortés", "CB", 66], ["Hamza Abdelkarim", "ST", 65]
    ]
  },
  "Real Madrid" => {
    short: "RMA", color: "#e8e8e8", stadium: "Santiago Bernabéu",
    players: [
      ["Mbappé", "ST", 91, %w[LW]], ["Courtois", "GK", 90], ["Bellingham", "CAM", 90, %w[CM LM]],
      ["Vini Jr", "LW", 89, %w[ST LM]], ["Valverde", "CM", 87, %w[RB RM]], ["Cucurella", "LB", 86],
      ["Trent Alexander-Arnold", "RB", 84, %w[RM]], ["Tchouaméni", "CDM", 84, %w[CM CB]], ["Yan Diomande", "RW", 84, %w[LW RM]],
      ["Militão", "CB", 84], ["Bernardo Silva", "CM", 84, %w[CDM RW]], ["Rodrygo", "LW", 84, %w[RW ST]],
      ["Konaté", "CB", 84], ["Dumfries", "RB", 83, %w[RM]], ["Rüdiger", "CB", 83],
      ["Arda Güler", "RM", 83, %w[CM CAM]], ["Camavinga", "CM", 81, %w[CDM LB]], ["Carreras", "LB", 81, %w[CB LM]],
      ["Huijsen", "CB", 81], ["Brahim Díaz", "RM", 81, %w[LM ST]], ["Mendy", "LB", 80],
      ["Lunin", "GK", 80], ["Endrick", "ST", 79, %w[RW CAM]], ["Asencio", "CB", 78, %w[RB]],
      ["Carlos Espí", "ST", 77], ["Thiago Pitarch", "CM", 70, %w[CDM CAM]]
    ]
  },
  "Atlético de Madrid" => {
    short: "ATM", color: "#cb3524", stadium: "Metropolitano",
    players: [
      ["Oblak", "GK", 88], ["Julián Álvarez", "ST", 86, %w[CAM]], ["Marcos Llorente", "RB", 85, %w[RM CM]],
      ["Grimaldo", "LM", 85, %w[LB CAM]], ["Hjulmand", "CDM", 83, %w[CM]], ["Pablo Barrios", "CM", 83, %w[CDM]],
      ["Hancko", "CB", 83, %w[LB]], ["Baena", "LM", 83, %w[CM CAM]], ["Lookman", "ST", 83, %w[CAM LM]],
      ["Sørloth", "ST", 83, %w[RW RM]], ["Giuliano Simeone", "RM", 82, %w[RW LM]], ["Musso", "GK", 82],
      ["Cristian Romero", "CB", 82], ["Giménez", "CB", 82], ["Pubill", "CB", 81, %w[RB]],
      ["Koke", "CM", 81, %w[CDM]], ["Le Normand", "CB", 81], ["Johnny Cardoso", "CDM", 80, %w[CM]],
      ["Lee Kang In", "RW", 80, %w[CAM RM]], ["Thomas Lemar", "CM", 77, %w[CAM LM]], ["Obed Vargas", "CDM", 72, %w[CM LM]],
      ["Rodri Mendoza", "CM", 71, %w[CAM]], ["Carlos Martín", "LW", 70, %w[RW ST]], ["Arnau Ortiz", "LM", 69, %w[LW]],
      ["Aleksa Purić", "CB", 67], ["Javi Boñar", "RB", 65, %w[CB]]
    ]
  },
  "Athletic Club" => {
    short: "ATH", color: "#c8102e", stadium: "San Mamés",
    players: [
      ["Unai Simón", "GK", 85], ["Nico Williams", "LW", 84, %w[LM]], ["Aymeric Laporte", "CB", 84],
      ["Sancet", "CAM", 82, %w[CM ST]], ["Vivian", "CB", 82, %w[RB]], ["Iñaki Williams", "RW", 80, %w[ST RM]],
      ["Yeray", "CB", 80], ["Jauregizar", "CM", 79, %w[CDM]], ["Yuri Berchiche", "LB", 79, %w[LM]],
      ["Berenguer", "RW", 79, %w[LM CAM]], ["Ruiz de Galarreta", "CDM", 79, %w[CM]], ["Guruzeta", "ST", 78],
      ["Aitor Paredes", "CB", 78], ["Beñat Prados", "CDM", 77, %w[CM CB]], ["Areso", "RB", 76, %w[RM]],
      ["Robert Navarro", "RW", 76, %w[RM LW]], ["Gorosabel", "RB", 76], ["Hugo Rincón", "RB", 75, %w[RM RW]],
      ["Álvaro Djaló", "RW", 74, %w[LW ST]], ["Peio Canales", "CAM", 73, %w[CM]], ["Adama Boiro", "LB", 73, %w[LM LW]],
      ["Rego", "CDM", 73, %w[CM]], ["Unai Vencedor", "CDM", 72, %w[CM]], ["Maroan", "ST", 71],
      ["Nico Serrano", "LW", 71, %w[LM RM]], ["Álex Padilla", "GK", 69]
    ]
  },
  "Osasuna" => {
    short: "OSA", color: "#d91a21", stadium: "El Sadar",
    players: [
      ["Ante Budimir", "ST", 82], ["Sergio Herrera", "GK", 79], ["Enzo Boyomo", "CB", 79],
      ["Valentin Rosier", "RB", 78, %w[RM RW]], ["Moncayola", "CM", 77, %w[CDM RM]], ["Aitor Fernández", "GK", 77],
      ["Rubén García", "RM", 77, %w[RW]], ["Catena", "CB", 77], ["Abel Bretones", "LB", 76, %w[LM LW]],
      ["Aimar Oroz", "CAM", 76, %w[CM LM]], ["Diego Rico", "LB", 76, %w[CB]], ["Moi Gómez", "CM", 76, %w[CDM]],
      ["Lucas Torró", "CDM", 76, %w[CM]], ["Raúl García", "ST", 75, %w[CAM]], ["Raúl Moro", "LW", 75, %w[LM RM]],
      ["Dubasin", "RW", 74, %w[LW ST]], ["Herrando", "CB", 74], ["Iker Muñoz", "CDM", 73, %w[CM]],
      ["Kike Barja", "LW", 73, %w[LM RW]], ["Osambela", "CB", 66, %w[CDM CM]], ["Rockson Yeboah", "CB", 65],
      ["Arguibide", "RB", 63, %w[RM RW]], ["Mauro Echegoyen", "CDM", 63, %w[CM]]
    ]
  },
  "Celta de Vigo" => {
    short: "CEL", color: "#8ac3ee", stadium: "Abanca Balaídos",
    players: [
      ["Iago Aspas", "RW", 81, %w[ST CAM]], ["Borja Iglesias", "ST", 80], ["Aleix Febas", "CM", 79, %w[CDM]],
      ["Marcos Alonso", "CB", 79, %w[LB]], ["Ilaix Moriba", "CM", 78, %w[CDM]], ["Ionuț Andrei Radu", "GK", 78],
      ["Carl Starfelt", "CB", 78], ["Javi Galán", "LB", 77, %w[LM]], ["Javi Rueda", "RB", 76, %w[RM RW]],
      ["Matías Vecino", "CM", 76, %w[CDM CAM]], ["Williot Swedberg", "LW", 76, %w[CM CAM]], ["Álvaro Núñez", "RB", 76, %w[RM CB]],
      ["Carreira", "RB", 76, %w[RM LM]], ["Javi Rodríguez", "CB", 76, %w[RB]], ["Hugo Álvarez", "LM", 75, %w[RM LW]],
      ["Altay Bayındır", "GK", 75], ["Ferran Jutglà", "ST", 75, %w[RW LW]], ["Miguel Román", "CM", 74, %w[CDM]],
      ["Pablo Durán", "ST", 74, %w[LW CAM]], ["Carles Pérez", "RM", 72, %w[LM RW]], ["Iván Villar", "GK", 72],
      ["Jones El-Abdellaoui", "RW", 72, %w[RM LM]], ["Abdoulaye Faye", "CB", 71], ["Yoel Lago", "CB", 71],
      ["Hugo González", "RM", 68, %w[RW LM]]
    ]
  },
  "Alavés" => {
    short: "ALA", color: "#0761af", stadium: "Mendizorrotza",
    players: [
      ["Toni Martínez", "ST", 78], ["Antonio Blanco", "CDM", 78, %w[CM]], ["Sivera", "GK", 77],
      ["Lucas Boyé", "ST", 77, %w[CAM]], ["Nahuel Tenaglia", "CB", 77, %w[RB]], ["Jonny", "RB", 76, %w[LB CB]],
      ["Denis Suárez", "CM", 74, %w[LM CDM]], ["Aleñá", "LM", 74, %w[CM RM]], ["Ander Guevara", "CDM", 74, %w[CM]],
      ["Abde Rebbach", "LW", 73, %w[LM LB]], ["Pablo Ibáñez", "CM", 73, %w[CDM]], ["Carlos Protesoni", "CDM", 73, %w[CM CB]],
      ["Nicolás Valentini", "CB", 73], ["Ángel Pérez", "RM", 72, %w[RB LM]], ["Miguel Rodríguez", "RW", 72, %w[RM]],
      ["Yusi", "LB", 70, %w[LM]], ["Adrián Rodríguez", "GK", 68], ["Ville Koski", "CB", 68, %w[CDM]],
      ["Mikel Rodríguez", "CM", 67, %w[CDM]], ["Mariano", "ST", 67], ["Owono", "GK", 67],
      ["Selu Diallo", "CM", 64, %w[CDM CAM]], ["Hugo Novoa", "RM", 64, %w[RB]], ["Aitor Mañas", "ST", 64],
      ["Xanet Oláiz", "CB", 63, %w[LB]], ["Tomás Mendes", "CM", 62, %w[CDM]]
    ]
  },
  "Elche" => {
    short: "ELC", color: "#1b8e3e", stadium: "Martínez Valero",
    players: [
      ["Valera", "LM", 76, %w[LB RM]], ["Matías Dituro", "GK", 76], ["David Affengruber", "CB", 76],
      ["Bigas", "CB", 76], ["Marc Aguado", "CDM", 74, %w[CM]], ["Víctor Chust", "CB", 74],
      ["Facundo Buonanotte", "CAM", 74, %w[RM CM]], ["Martim Neto", "CM", 72, %w[CDM CAM]], ["Josan", "RM", 72, %w[RB RW]],
      ["Gonzalo Villar", "CM", 72, %w[CAM CDM]], ["Ezequiel Ponce", "ST", 72], ["Fer Niño", "ST", 72, %w[CAM]],
      ["Lucas Cepeda", "LW", 71, %w[CM CAM]], ["Tete Morente", "LM", 71, %w[LW RM]], ["Federico Redondo", "CM", 70, %w[CDM]],
      ["Grady Diangana", "CAM", 70, %w[RM CM]], ["Yago Santiago", "LW", 70, %w[LM RM]], ["Buba Sangaré", "RB", 69, %w[CB RM]],
      ["John Donald", "CB", 69, %w[CDM CM]], ["Abiel Osorio", "ST", 68, %w[CAM]], ["Matia Barzić", "CB", 68],
      ["Bambo Diaby", "CB", 67], ["Iturbe", "GK", 66], ["Ali Houary", "CAM", 65, %w[CM]],
      ["Adam Boayar", "ST", 64], ["Álex Sánchez", "RM", 62, %w[LM CAM]]
    ]
  },
  "Getafe" => {
    short: "GET", color: "#005999", stadium: "Coliseum",
    players: [
      ["David Soria", "GK", 80], ["Martín Satriano", "ST", 77, %w[LW LM]], ["Dakonam Djené", "CB", 77, %w[RB CDM]],
      ["Zaid Romero", "CB", 77, %w[LB]], ["Johan Mojica", "LB", 76, %w[LM]], ["Borja Mayoral", "ST", 76],
      ["Christantus Uche", "ST", 75, %w[CAM CM]], ["Orel Mangala", "CDM", 75, %w[CM]], ["Enes Ünal", "ST", 75],
      ["Javi Muñoz", "CM", 74, %w[CAM RM]], ["Mario Martín", "CM", 74, %w[CDM CAM]], ["Terrats", "RM", 74, %w[CM CAM]],
      ["Sebastián Boselli", "CB", 74, %w[RB CDM]], ["Kiko Femenía", "RB", 74, %w[RM CDM]], ["Abdelkabir Abqar", "CB", 74],
      ["Yvan Neyou", "CM", 73, %w[CDM]], ["Andrés García", "RB", 73, %w[RM]], ["Álex Sancris", "RM", 73, %w[LM RW]],
      ["Saba Sazonov", "CB", 73], ["Francho Serrano", "CM", 72, %w[RM RB]], ["Juanmi", "ST", 71, %w[LM LW]],
      ["Jiří Letáček", "GK", 69], ["Davinchi", "LB", 69, %w[LM]], ["Berrocal", "CB", 69],
      ["Jean Ives Valou", "CB", 66, %w[LB]], ["Ismael Bekhoucha", "RB", 64]
    ]
  },
  "Levante" => {
    short: "LEV", color: "#b4053f", stadium: "Ciutat de València",
    players: [
      ["Mathew Ryan", "GK", 79], ["Aïssa Mandi", "CB", 79, %w[RB]], ["Carlos Álvarez", "RM", 77, %w[CAM RW]],
      ["Manu Sánchez", "LB", 76], ["Iván Romero", "ST", 75, %w[LM LW]], ["Karl Etta Eyong", "ST", 75],
      ["Hugo Sotelo", "CM", 74, %w[CDM]], ["Jeremy Toljan", "RB", 74, %w[RM]], ["Dela", "CB", 74, %w[RB]],
      ["Olasagasti", "CM", 74, %w[CDM LM]], ["Brugui", "ST", 74, %w[LM RM]], ["Thiago Fernández", "LM", 74, %w[LW]],
      ["Oriol Rey", "CM", 73, %w[CDM CB]], ["Enzo Bardeli", "CM", 73, %w[CAM LM]], ["Víctor García", "RM", 72, %w[RB]],
      ["Dani Requena", "CM", 70, %w[CAM CDM]], ["Kareem Tunde", "RM", 69, %w[LM RW]], ["Pablo Campos", "GK", 69],
      ["Paco Cortés", "LW", 68, %w[LM]], ["Tay Abed", "RW", 67, %w[RM]], ["Xavi Grande", "RB", 67, %w[RM RW]],
      ["Nacho Pérez", "RB", 67], ["Cabello", "CB", 67, %w[LB]], ["Dani Martín", "GK", 62],
      ["Martín Wilhelm Krug", "CB", 62], ["Ifeanyi Ndukwe", "CB", 61]
    ]
  },
  "Málaga" => {
    short: "MAL", color: "#0b5ea8", stadium: "La Rosaleda",
    players: [
      ["Pablo Martínez", "CM", 76, %w[LM CDM]], ["Chupe", "ST", 76], ["Alfonso Herrero", "GK", 75],
      ["Larrubia", "RW", 75, %w[RM]], ["Calero", "CB", 75], ["Dani Lorenzo", "CAM", 72, %w[CM ST]],
      ["Salinas", "LB", 72, %w[LM LW]], ["Adrián Niño", "ST", 72, %w[LW]], ["Murillo", "CB", 72, %w[RB CDM]],
      ["Puga", "RB", 71, %w[RM]], ["Joaquín Muñoz", "LW", 71, %w[LM]], ["Izan Merino", "CDM", 70, %w[CM]],
      ["Dotor", "CAM", 70, %w[CM ST]], ["Juan Cruz", "RM", 70, %w[CAM LM]], ["Einar Galilea", "CB", 69],
      ["Rafa Rodríguez", "CAM", 68, %w[ST CM]], ["Rafita", "RB", 68, %w[LB RM]], ["Jauregi", "ST", 68],
      ["Álex Pastor", "CB", 67], ["Aarón Ochoa", "LM", 66, %w[CAM ST]], ["Lobete", "LW", 66, %w[ST RW]],
      ["Dani Sánchez", "LB", 65, %w[LM]], ["Ramón Enríquez", "CM", 65, %w[CDM]], ["Ángel Recio", "CB", 65],
      ["Haitam Abaida", "RW", 63, %w[LW RM]], ["Carlos López", "GK", 62]
    ]
  },
  "Racing de Santander" => {
    short: "RAC", color: "#00a651", stadium: "El Sardinero",
    players: [
      ["Sergio Canales", "RM", 78, %w[CAM LM]], ["Iván Martín", "CM", 77, %w[CDM CAM]], ["Iñigo Vicente", "LM", 77, %w[CAM LW]],
      ["Andrés Martín", "RW", 77, %w[RM]], ["Agirrezabala", "GK", 76], ["Gustavo Puerta", "CDM", 74, %w[CM]],
      ["Villalibre", "ST", 74], ["Jorge Salinas", "LB", 72, %w[CB]], ["Mantilla", "RB", 71, %w[CDM]],
      ["Arana", "ST", 70], ["Pedro Felipe", "CB", 69], ["Simon Eriksson", "GK", 69],
      ["Giorgi Guliashvili", "ST", 69], ["Maguette Gueye", "CDM", 69, %w[CM]], ["Pablo Ramón", "CB", 69],
      ["Manu Hernando", "CB", 69], ["Facundo González", "CB", 69], ["Íñigo Sainz-Maza", "CDM", 67, %w[CM]],
      ["Yassir Zabiri", "ST", 66], ["Sergio Martínez", "CDM", 64, %w[CM]], ["Aitor Crespo", "CB", 60],
      ["Laro Gómez", "GK", 60], ["Diego Díaz", "CAM", 59, %w[CM]]
    ]
  },
  "Rayo Vallecano" => {
    short: "RAY", color: "#e53027", stadium: "Estadio de Vallecas",
    players: [
      ["De Frutos", "RW", 81, %w[ST RM]], ["Álvaro García", "LW", 81, %w[LM ST]], ["Andrei Rațiu", "RB", 80, %w[RM RW]],
      ["Isi", "CAM", 80, %w[RM ST]], ["Augusto Batalla", "GK", 79], ["Florian Lejeune", "CB", 79],
      ["Pathé Ciss", "CDM", 77, %w[CM CB]], ["Óscar Valentín", "CDM", 77, %w[CM]], ["Unai López", "CM", 76, %w[CDM]],
      ["Pedro Díaz", "CM", 75, %w[CDM CAM]], ["Luiz Felipe", "CB", 75], ["Marash Kumbulla", "CB", 75],
      ["Iván Balliu", "RB", 74, %w[LB RM]], ["Dani Cárdenas", "GK", 74], ["Sergio Camello", "ST", 74, %w[CAM]],
      ["Alemão", "ST", 74], ["Fran Pérez", "RW", 74, %w[LW RM]], ["Giorgi Tsitaishvili", "LM", 74, %w[LB LW]],
      ["Raúl De Tomás", "ST", 72], ["Randy Nteka", "ST", 70, %w[CAM CM]], ["Jozhua Vertrouwd", "CB", 68, %w[LB LM]],
      ["Miguel Morro", "GK", 65], ["Diego Méndez", "CDM", 64, %w[CM]], ["Pelayo Fernández", "CB", 64],
      ["Etienne Eto'o", "ST", 63, %w[CAM]], ["Samu Becerra", "CM", 61, %w[CAM RM]]
    ]
  },
  "Deportivo de La Coruña" => {
    short: "DEP", color: "#0a3a8c", stadium: "Riazor",
    players: [
      ["Pierre-Emerick Aubameyang", "ST", 79], ["Angeliño", "LB", 78, %w[LM]], ["Leo Román", "GK", 77],
      ["Yeremay", "LM", 77, %w[ST CAM]], ["Mario Soriano", "CAM", 75, %w[CM ST]], ["Álvaro Ferllo", "GK", 74],
      ["Luismi Cruz", "RW", 74, %w[CAM LW]], ["Villares", "CM", 73, %w[CDM]], ["Alti", "RB", 73, %w[RM RW]],
      ["Lorenzo Amatucci", "CM", 73, %w[CDM]], ["Giacomo Quagliata", "LB", 73, %w[LM LW]], ["Loureiro", "CB", 73, %w[RB CDM]],
      ["Mella", "RM", 73, %w[RB LM]], ["Lucas Noubi", "CB", 73, %w[RB CDM]], ["Ximo Navarro", "RB", 72, %w[CB]],
      ["Riki", "CM", 72, %w[CDM]], ["Zakaria Eddahchouri", "ST", 72], ["Dani Barcia", "CB", 71],
      ["Jonathan Asp-Jensen", "LW", 69, %w[CAM CM]], ["José Ángel", "CDM", 69, %w[CM]], ["Bil Nsongo", "ST", 69],
      ["Germán Parreño", "GK", 68], ["Arnau Comas", "CB", 68], ["Charlie Patiño", "CM", 67, %w[CDM CAM]],
      ["Bright Ede", "CB", 66], ["Jairo Noriega", "CAM", 64, %w[CM]]
    ]
  },
  "Espanyol" => {
    short: "ESP", color: "#007fc8", stadium: "RCDE Stadium",
    players: [
      ["Marko Dmitrović", "GK", 79], ["Edu Expósito", "CAM", 77, %w[CM CDM]], ["Puado", "LW", 77, %w[ST CAM]],
      ["Urko González", "CDM", 76, %w[CM]], ["Leandro Cabrera", "CB", 76], ["Cala", "CAM", 75, %w[ST RM]],
      ["Quilindschy Hartman", "LB", 75], ["Pere Milla", "LM", 75, %w[ST CAM]], ["Pol Lozano", "CDM", 75, %w[CM]],
      ["Omar El Hilali", "RB", 75, %w[CB CDM]], ["Kike García", "ST", 75, %w[CAM]], ["Unai Núñez", "CB", 75, %w[RB]],
      ["Roberto Fernández", "ST", 74], ["Tyrhys Dolan", "RW", 74, %w[RM LM]], ["Jofre", "RW", 73, %w[RM LM]],
      ["Javi Hernández", "RM", 73, %w[ST CAM]], ["Gabriel Moscardo", "CDM", 72, %w[CM CB]], ["Marcos Fernández", "ST", 72],
      ["Rubén Sánchez", "RB", 71, %w[RM RW]], ["Vanja Drkušić", "CB", 71, %w[RB]], ["Clemens Riedel", "CB", 70, %w[RB]],
      ["Rafa Bauza", "CDM", 68, %w[CM]], ["Roger Hinojo", "LB", 68, %w[CB CDM]], ["Fortuño", "GK", 65],
      ["Llorenç Serred", "GK", 62]
    ]
  },
  "Real Betis" => {
    short: "BET", color: "#00954c", stadium: "Benito Villamarín",
    players: [
      ["Isco", "CAM", 83, %w[CM CDM]], ["Fornals", "CM", 81, %w[CAM CDM]], ["Antony", "RW", 81, %w[RM]],
      ["Abde", "LW", 81, %w[LM]], ["Giovani Lo Celso", "CAM", 80, %w[CM CDM]], ["Cucho Hernández", "ST", 79, %w[CAM]],
      ["Bartra", "CB", 79], ["Diego Llorente", "CB", 79], ["Natan", "CB", 79],
      ["Marc Roca", "CDM", 78, %w[CM]], ["Troy Parrott", "ST", 78, %w[CAM]], ["Aitor Ruibal", "RM", 77, %w[RB LM]],
      ["Álvaro Valles", "GK", 77], ["Fran García", "LB", 77, %w[LM]], ["Fidalgo", "CM", 77, %w[CAM CDM]],
      ["Héctor Bellerín", "RB", 76, %w[RM]], ["Diego Conde", "GK", 76], ["Riquelme", "LM", 76, %w[CAM RM]],
      ["Valentín Gómez", "CB", 76, %w[LB]], ["Nelson Deossa", "CDM", 75, %w[CM CAM]], ["Junior Firpo", "LB", 74, %w[LM]],
      ["Facundo Bernal", "CDM", 74, %w[CM]], ["Iker Losada", "CAM", 72, %w[LM CM]], ["Pablo García", "RW", 70, %w[RM LM]],
      ["Ángel Ortiz", "RB", 70], ["Gonzalo Petit", "ST", 69]
    ]
  },
  "Real Sociedad" => {
    short: "RSO", color: "#0067b1", stadium: "Reale Arena",
    players: [
      ["Oyarzabal", "ST", 84], ["Álex Remiro", "GK", 81], ["Takefusa Kubo", "RM", 80, %w[RW]],
      ["Guedes", "LW", 80, %w[RM ST]], ["Carlos Soler", "CM", 79, %w[CAM CDM]], ["Barrenetxea", "LW", 79, %w[LM RM]],
      ["Yangel Herrera", "CM", 78, %w[CDM]], ["Sergio Gómez", "LB", 78, %w[LM CM]], ["Gorrotxa", "CDM", 78, %w[CM]],
      ["Jon Martín", "CB", 78], ["Zubeldia", "CB", 77], ["Jon Mikel Aramburu", "RB", 77],
      ["Luka Sučić", "CM", 76, %w[CAM ST]], ["Turrientes", "CDM", 76, %w[CM]], ["Unai Marrero", "GK", 74],
      ["Orri Óskarsson", "ST", 74], ["Pacheco", "CB", 74, %w[LB]], ["Pablo Marín", "CM", 73, %w[CDM LM]],
      ["Aihen Muñoz", "LB", 73], ["Odriozola", "RB", 73], ["Arsen Zakharyan", "RM", 73, %w[CM LM]],
      ["Mikel Goti", "CAM", 69, %w[CM RM]], ["Job Nguono Ochieng", "LM", 68, %w[RM LW]], ["Karrikaburu", "ST", 67, %w[CAM]]
    ]
  },
  "Sevilla" => {
    short: "SEV", color: "#d4021d", stadium: "Ramón Sánchez-Pizjuán",
    players: [
      ["Odysseas Vlachodimos", "GK", 79], ["Rubén Vargas", "LW", 78, %w[CAM RW]], ["Carmona", "RB", 77, %w[CB LB]],
      ["Lucien Agoumé", "CDM", 76, %w[CM CAM]], ["Chidera Ejuke", "LW", 76, %w[LM RM]], ["Juan Iglesias", "RB", 76, %w[LB RM]],
      ["Kike Salas", "CB", 76, %w[LB CDM]], ["Alfon", "LW", 75, %w[LM CAM]], ["Giorgi Kochorashvili", "CM", 74, %w[CDM CAM]],
      ["Adrià Pedrosa", "LB", 74, %w[LM LW]], ["Gabriel Suazo", "LB", 74, %w[LM LW]], ["Isaac Romero", "ST", 74, %w[CAM]],
      ["Peque", "CAM", 74, %w[LM ST]], ["Arouna Sangante", "CB", 74, %w[RB]], ["Oso", "LB", 73, %w[LM LW]],
      ["Guridi", "CM", 73, %w[CAM ST]], ["Marcão", "CB", 73], ["Andrés Castrín", "CB", 73],
      ["Fábio Cardoso", "CB", 73], ["Robbie Ure", "ST", 71], ["Julio Díaz", "LB", 68, %w[LM LW]],
      ["Manu Bueno", "CM", 67, %w[CAM CDM]], ["Miguel Sierra", "RW", 65, %w[LW RM]], ["Fran González", "GK", 65],
      ["Nico Guillén", "CM", 63, %w[CDM]], ["Rafa Romero", "GK", 62]
    ]
  },
  "Valencia" => {
    short: "VAL", color: "#f47b20", stadium: "Mestalla",
    players: [
      ["Guido Rodríguez", "CDM", 78, %w[CM]], ["Javi Guerra", "CM", 77, %w[CDM CAM]], ["Gayà", "LB", 77, %w[LM]],
      ["Maffeo", "RB", 77], ["Hugo Duro", "ST", 77], ["Luis Rioja", "RM", 77, %w[LM RW]],
      ["Stole Dimitrievski", "GK", 77], ["Diego López", "LW", 77, %w[RM ST]], ["Pepelu", "CM", 76, %w[CDM CB]],
      ["Umar Sadiq", "ST", 76], ["Mouctar Diakhaby", "CB", 76], ["Justin de Haas", "CB", 76],
      ["Filip Ugrinić", "CM", 75, %w[CDM CAM]], ["Arnaut Danjuma", "LW", 75, %w[ST LM]], ["César Tárrega", "CB", 75],
      ["André Almeida", "CAM", 74, %w[LM ST]], ["Dani Raba", "RW", 74, %w[ST CAM]], ["Copete", "CB", 74],
      ["Aliou Dieng", "CDM", 73, %w[CM]], ["Dimitri Foulquier", "RB", 72, %w[CB CDM]], ["Jesús Vázquez", "LB", 71, %w[LM]],
      ["Ryunosuke Sato", "LM", 71, %w[RM CM]], ["Sergi Canós", "LM", 68, %w[LW RM]], ["Cristian Rivero", "GK", 65],
      ["Iker Córdoba", "CB", 65], ["David Otorbi", "RW", 64, %w[RM LM]]
    ]
  },
  "Villarreal" => {
    short: "VIL", color: "#f5d90a", stadium: "Estadio de la Cerámica",
    players: [
      ["Péter Gulácsi", "GK", 82], ["Moleiro", "LM", 82, %w[CAM LW]], ["Gerard Moreno", "ST", 81, %w[RW CAM]],
      ["Nicolas Pépé", "RW", 81, %w[ST RM]], ["Carlos Romero", "LB", 80, %w[LM]], ["Pape Gueye", "CM", 80, %w[CDM]],
      ["Ayoze", "ST", 80, %w[LW CAM]], ["Sergi Cardona", "LB", 79, %w[LM]], ["Santi Comesaña", "CM", 79, %w[CDM]],
      ["Georges Mikautadze", "ST", 79], ["Juan Foyth", "CB", 79, %w[RB]], ["Renato Veiga", "CB", 78],
      ["Santiago Mouriño", "RB", 78, %w[CB]], ["Luiz Júnior", "GK", 78], ["Tajon Buchanan", "RM", 76, %w[RW]],
      ["Logan Costa", "CB", 76], ["Ilias Akhomach", "RW", 75, %w[RM]], ["Pau Navarro", "CB", 74, %w[RB CM]],
      ["Alex Freeman", "RB", 73, %w[CM]], ["Willy Kambwala", "CB", 72], ["Tani Oluwaseyi", "ST", 71, %w[RM]],
      ["Carlos Macià", "CM", 65, %w[CDM]], ["Rubén Gómez", "GK", 63], ["Alassane Diatta", "CDM", 62, %w[CM]]
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
    data[:players].each do |pname, pos, ovr, alts|
      team.players.create!(name: pname, position: pos, overall: ovr, alt_positions: (alts || []).join(","))
    end
    team.auto_lineup!("4-3-3")
  end
end

puts "Pronto: #{Team.count} times, #{Player.count} jogadores. O calendário é criado ao escolher seu time."
