require "test_helper"

class PlayerTemplateTest < ActiveSupport::TestCase
  def build_team
    Team.create!(name: "Template Team", short_name: "TPL", color: "#111111", stadium: "Arena")
  end

  def add_roster(team, prefix)
    positions = %w[GK CB CB LB RB CDM CM CM CAM LW ST]
    positions.each_with_index do |position, index|
      player = team.players.create!(name: "#{prefix} #{index}", position: position, overall: 70, age: 25, stamina: 80)
      PlayerTemplate.create!(team: team, source_player_id: player.id,
                             name: player.name, position: position, overall: player.overall,
                             age: player.age, stamina: player.stamina)
    end
  end

  test "alterar jogador da base nao modifica a carreira salva ate iniciar outra" do
    team = build_team
    career_player = team.players.create!(name: "Jogador", position: "CM", overall: 75, age: 25, stamina: 80, fatigue: 30)
    template = PlayerTemplate.create!(team: team, source_player_id: career_player.id,
                                      name: career_player.name, position: career_player.position,
                                      overall: career_player.overall, age: career_player.age,
                                      stamina: career_player.stamina)

    template.update!(overall: 88)

    assert_equal 75, career_player.reload.overall
    PlayerTemplate.sync_to_players!
    assert_equal 88, career_player.reload.overall
    assert_equal 0, career_player.fatigue
  end

  test "dataset de idades retorna idade verificada e padrao para nome sem fonte" do
    assert_equal 19, PlayerTemplate.seed_age_for("Barcelona", "Yamal")
    assert_equal 25, PlayerTemplate.seed_age_for("Barcelona", "Jogador sem fonte")
  end

  test "dataset do seed restaura retrato confirmado e deixa ausente sem imagem" do
    assert_match %r{\Ahttps://img\.a\.transfermarkt\.technology/portrait/},
                 PlayerTemplate.seed_photo_url_for("Barcelona", "Yamal")
    assert_nil PlayerTemplate.seed_photo_url_for("Barcelona", "Jogador sem foto")
  end

  test "jogador novo da base e criado no elenco ao sincronizar nova carreira" do
    team = build_team
    template = PlayerTemplate.create!(team: team, name: "Novo Jogador", position: "ST", overall: 72)

    PlayerTemplate.sync_to_players!

    career_player = team.players.find_by!(name: "Novo Jogador")
    assert_equal 72, career_player.overall
    assert_equal career_player.id, template.reload.source_player_id
  end

  test "iniciar uma nova carreira aplica a versao atual dos jogadores da base" do
    home = build_team
    away = Team.create!(name: "Other Team", short_name: "OTH", color: "#222222", stadium: "Ground")
    add_roster(home, "Home")
    add_roster(away, "Away")
    template = PlayerTemplate.find_by!(team: home, name: "Home 1")
    template.update!(overall: 91)

    Career.start!(home)

    assert_equal 91, Player.find_by!(id: template.source_player_id).overall
    assert_equal home.id, Career.current.team_id

    template.update!(overall: 96)
    assert_equal 91, Player.find_by!(id: template.source_player_id).reload.overall
  end
end