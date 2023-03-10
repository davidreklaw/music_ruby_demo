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

ActiveRecord::Schema[7.0].define(version: 2023_01_27_153645) do
  create_table "playlist_tracks", force: :cascade do |t|
    t.integer "playlist_id_id", null: false
    t.integer "song_id_id", null: false
    t.index ["playlist_id_id"], name: "index_playlist_tracks_on_playlist_id_id"
    t.index ["song_id_id"], name: "index_playlist_tracks_on_song_id_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.integer "playlist_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.string "genre"
    t.string "release_data"
    t.integer "song_id"
    t.string "artist_id"
    t.string "album"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "cover_url"
    t.string "youtube_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "user_id"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "playlist_tracks", "playlist_ids"
  add_foreign_key "playlist_tracks", "song_ids"
end
