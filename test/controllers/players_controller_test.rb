require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "bulk salva URL do retrato somente no jogador da base" do
    team = Team.create!(name: "Photo Team", short_name: "PHT", color: "#111111", stadium: "Arena")
    template = PlayerTemplate.create!(team: team, name: "Photo Player", position: "CM", overall: 70)
    photo_url = "https://img.a.transfermarkt.technology/portrait/medium/108390-1717280733.jpg?lm=4711"

    patch bulk_players_path, params: {
      view_team_id: team.id,
      players: { template.id.to_s => { name: template.name, photo_url: photo_url } }
    }

    assert_response :see_other
    assert_equal photo_url, template.reload.photo_url
    assert_nil Player.find_by(name: template.name)
  end
end
