require "test_helper"

class PlayerStaminaTest < ActiveSupport::TestCase
  def build_player(age:, fatigue: 10, stamina: 80)
    Team.create!(name: "Test Team", short_name: "TT", color: "#111111", stadium: "Arena")
    Player.new(
      team: Team.last,
      name: "Jogador Teste",
      position: "CM",
      overall: 80,
      age: age,
      stamina: stamina,
      fatigue: fatigue
    )
  end

  test "jovens cansam menos e velhos cansam mais" do
    young = build_player(age: 22, fatigue: 10)
    normal = build_player(age: 28, fatigue: 10)
    old = build_player(age: 36, fatigue: 10)

    assert_operator young.match_stamina_loss, :<, normal.match_stamina_loss
    assert_operator normal.match_stamina_loss, :<, old.match_stamina_loss
  end

  test "stamina diminui gradualmente durante a partida conforme idade e minutos" do
    young = build_player(age: 22, fatigue: 0)
    normal = build_player(age: 28, fatigue: 0)
    old = build_player(age: 36, fatigue: 0)

    assert_equal 95, normal.match_stamina_at(15)
    assert_equal 80, normal.match_stamina_at(60)
    assert_equal 75, normal.match_stamina_at(75)
    assert_operator normal.match_stamina_at(45), :<, 100
    assert_operator normal.match_stamina_at(45), :>, normal.match_stamina_at(90)
    assert_operator young.match_stamina_at(90), :>, normal.match_stamina_at(90)
    assert_operator old.match_stamina_at(90), :<, normal.match_stamina_at(90)
  end

  test "queda abaixo de 80 aumenta progressivamente a penalidade de desempenho" do
    player = build_player(age: 28, fatigue: 0)

    assert_equal 0.0, player.stamina_performance_penalty(80)
    assert_operator player.stamina_performance_penalty(79), :>, 0
    assert_operator player.stamina_performance_penalty(50), :>, player.stamina_performance_penalty(79)
    assert_equal 7.5, player.stamina_performance_penalty(70)
    assert_equal 15.0, player.stamina_performance_penalty(60)
    assert_equal 15.0, player.stamina_performance_penalty(0)
    assert_operator player.effective_rating(current_stamina: 79), :<, player.effective_rating(current_stamina: 80)
    assert_operator player.effective_rating(current_stamina: 40), :<, player.effective_rating(current_stamina: 79)
  end

  test "stamina baixa também reduz a nota final da partida" do
    player = build_player(age: 28, fatigue: 0)
    match = Match.new
    match.define_singleton_method(:rand) { 0.5 }

    fresh_grade, tired_grade = [100, 40].map do |stamina|
      match.send(:compute_rating, player, 0, 0, 0, 0, 90, 0, 0, stamina)
    end

    assert_operator fresh_grade, :>, tired_grade
  end

  test "a stamina ao vivo considera minutos reais em campo para titulares e reservas" do
    starter = build_player(age: 28, fatigue: 5).tap(&:save!)
    substitute = build_player(age: 22, fatigue: 5).tap(&:save!)
    match = Match.new(
      status: "live",
      minute: 75,
      starting_ids: { home: [starter.id], away: [] }.to_json,
      events: [{ type: "sub", minute: 60, in_id: substitute.id, out_id: starter.id }].to_json
    )

    assert_equal 60, match.player_minutes_at(starter.id)
    assert_equal 15, match.player_minutes_at(substitute.id)
    assert_equal starter.match_stamina_at(60), match.stamina_for(starter)
    assert_equal substitute.match_stamina_at(15), match.stamina_for(substitute)
  end

  test "jogadores muito cansados têm risco maior de lesão" do
    fresh = build_player(age: 25, fatigue: 15, stamina: 80)
    tired = build_player(age: 25, fatigue: 78, stamina: 55)

    assert_operator tired.injury_risk, :>, fresh.injury_risk
  end

  test "fadiga reduz a força efetiva no campo" do
    fresh = build_player(age: 25, fatigue: 10, stamina: 85)
    tired = build_player(age: 25, fatigue: 70, stamina: 60)

    assert_operator tired.effective_rating, :<, fresh.effective_rating
  end

  test "a recuperação após a partida reduz a fadiga de forma relevante" do
    player = build_player(age: 25, fatigue: 78, stamina: 70)

    player.recover_after_match!

    assert_equal 5, player.fatigue
    assert_equal 95, 100 - player.fatigue
  end

  test "titulares e reservas recuperam stamina ao finalizar a partida" do
    home = Team.create!(name: "Mandante", short_name: "MAN", color: "#111111", stadium: "Arena")
    away = Team.create!(name: "Visitante", short_name: "VIS", color: "#222222", stadium: "Arena")
    starter = home.players.create!(name: "Titular", position: "CM", overall: 80, age: 28, stamina: 80, fatigue: 50)
    bench = home.players.create!(name: "Reserva", position: "CM", overall: 75, age: 22, stamina: 80, fatigue: 50)
    match = Match.create!(home_team: home, away_team: away, round: 1, played: true, status: "finished",
                          home_goals: 0, away_goals: 0,
                          starting_ids: { home: [starter.id], away: [] }.to_json, events: "[]")

    match.finalize_stats!

    assert_equal 5, starter.reload.fatigue
    assert_equal 0, bench.reload.fatigue
  end
end
