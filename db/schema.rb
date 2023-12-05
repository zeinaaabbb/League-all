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

ActiveRecord::Schema[7.1].define(version: 2023_12_05_141818) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id", null: false
    t.index ["team_id"], name: "index_chatrooms_on_team_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "league_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_favourites_on_league_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "favourites_teams", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_favourites_teams_on_team_id"
    t.index ["user_id"], name: "index_favourites_teams_on_user_id"
  end

  create_table "fixtures", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "gameweek"
    t.datetime "time"
    t.integer "home_goals"
    t.integer "away_goals"
    t.bigint "home_team_id"
    t.bigint "away_team_id"
    t.bigint "league_id"
    t.integer "winning_team"
    t.boolean "draw"
    t.index ["away_team_id"], name: "index_fixtures_on_away_team_id"
    t.index ["home_team_id"], name: "index_fixtures_on_home_team_id"
    t.index ["league_id"], name: "index_fixtures_on_league_id"
  end

  create_table "league_notifications", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_notifications_on_league_id"
    t.index ["user_id"], name: "index_league_notifications_on_user_id"
  end

  create_table "league_teams_joins", force: :cascade do |t|
    t.boolean "accepted"
    t.bigint "league_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_teams_joins_on_league_id"
    t.index ["team_id"], name: "index_league_teams_joins_on_team_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "format"
    t.date "start_date"
    t.string "level"
    t.string "league_type"
    t.integer "number_of_teams"
    t.integer "days_per_week"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_leagues_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chatroom_id", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["team_id"], name: "index_messages_on_team_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "points", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "league_id", null: false
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_points_on_league_id"
    t.index ["team_id"], name: "index_points_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chatrooms", "teams"
  add_foreign_key "favourites", "leagues"
  add_foreign_key "favourites", "users"
  add_foreign_key "favourites_teams", "teams"
  add_foreign_key "favourites_teams", "users"
  add_foreign_key "fixtures", "leagues"
  add_foreign_key "fixtures", "teams", column: "away_team_id"
  add_foreign_key "fixtures", "teams", column: "home_team_id"
  add_foreign_key "league_notifications", "leagues"
  add_foreign_key "league_notifications", "users"
  add_foreign_key "league_teams_joins", "leagues"
  add_foreign_key "league_teams_joins", "teams"
  add_foreign_key "leagues", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "teams"
  add_foreign_key "messages", "users"
  add_foreign_key "players", "teams"
  add_foreign_key "players", "users"
  add_foreign_key "points", "leagues"
  add_foreign_key "points", "teams"
  add_foreign_key "teams", "users"
end
