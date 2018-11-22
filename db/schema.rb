# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_22_023944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clues", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "target_id", null: false
    t.bigint "day_id", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_clues_on_day_id"
    t.index ["target_id"], name: "index_clues_on_target_id"
    t.index ["user_id"], name: "index_clues_on_user_id"
  end

  create_table "days", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "index", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "index"], name: "index_days_on_game_id_and_index", unique: true
    t.index ["game_id"], name: "index_days_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "signup_end_date", default: "2018-11-22", null: false
    t.date "game_start_date", default: "2018-11-22", null: false
    t.date "game_end_date", default: "2018-11-22", null: false
  end

  create_table "guesses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ninja_id", null: false
    t.bigint "day_id", null: false
    t.boolean "correct", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_guesses_on_day_id"
    t.index ["ninja_id"], name: "index_guesses_on_ninja_id"
    t.index ["user_id"], name: "index_guesses_on_user_id"
  end

  create_table "pairings", force: :cascade do |t|
    t.bigint "target_id", null: false
    t.bigint "ninja_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_pairings_on_game_id"
    t.index ["ninja_id"], name: "index_pairings_on_ninja_id"
    t.index ["target_id"], name: "index_pairings_on_target_id"
  end

  create_table "user_games", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_user_games_on_game_id"
    t.index ["user_id"], name: "index_user_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
