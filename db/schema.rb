# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_24_000003) do
  create_table "careers", force: :cascade do |t|
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_careers_on_team_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "home_team_id", null: false
    t.integer "away_team_id", null: false
    t.integer "round", null: false
    t.integer "home_goals"
    t.integer "away_goals"
    t.boolean "played", default: false, null: false
    t.text "events"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "scheduled", null: false
    t.integer "minute", default: 0, null: false
    t.integer "subs_home", default: 0, null: false
    t.integer "subs_away", default: 0, null: false
    t.text "subbed_off"
    t.text "starting_ids"
  end

  create_table "player_match_stats", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "player_id", null: false
    t.integer "team_id", null: false
    t.integer "goals", default: 0, null: false
    t.integer "assists", default: 0, null: false
    t.integer "yellow_cards", default: 0, null: false
    t.integer "red_cards", default: 0, null: false
    t.integer "minutes", default: 0, null: false
    t.float "rating", default: 6.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id", "player_id"], name: "index_player_match_stats_on_match_id_and_player_id", unique: true
    t.index ["match_id"], name: "index_player_match_stats_on_match_id"
    t.index ["player_id"], name: "index_player_match_stats_on_player_id"
    t.index ["team_id"], name: "index_player_match_stats_on_team_id"
  end

  create_table "player_templates", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "source_player_id"
    t.string "name", null: false
    t.string "position", null: false
    t.integer "overall", null: false
    t.string "alt_positions", default: "", null: false
    t.integer "age", default: 25, null: false
    t.integer "stamina", default: 80, null: false
    t.integer "pace"
    t.integer "shooting"
    t.integer "passing"
    t.integer "dribbling"
    t.integer "defending"
    t.integer "physical"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_url"
    t.index ["source_player_id"], name: "index_player_templates_on_source_player_id", unique: true
    t.index ["team_id"], name: "index_player_templates_on_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "team_id", null: false
    t.string "name", null: false
    t.string "position", null: false
    t.integer "overall", null: false
    t.boolean "starter", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "slot"
    t.string "alt_positions", default: "", null: false
    t.integer "pace"
    t.integer "shooting"
    t.integer "passing"
    t.integer "dribbling"
    t.integer "defending"
    t.integer "physical"
    t.integer "age", default: 25, null: false
    t.integer "stamina", default: 80, null: false
    t.integer "fatigue", default: 0, null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_settings_on_key", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.string "short_name", null: false
    t.string "color", default: "#333333"
    t.string "stadium"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "formation", default: "4-3-3", null: false
  end

  add_foreign_key "careers", "teams"
  add_foreign_key "player_match_stats", "matches"
  add_foreign_key "player_match_stats", "players"
  add_foreign_key "player_templates", "teams"
  add_foreign_key "players", "teams"
end
