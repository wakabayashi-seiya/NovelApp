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

ActiveRecord::Schema.define(version: 20190808031807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "novel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["novel_id", "user_id"], name: "index_favorites_on_novel_id_and_user_id", unique: true
    t.index ["novel_id"], name: "index_favorites_on_novel_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_notes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "novel_tag_relations", force: :cascade do |t|
    t.bigint "novel_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["novel_id"], name: "index_novel_tag_relations_on_novel_id"
    t.index ["tag_id"], name: "index_novel_tag_relations_on_tag_id"
  end

  create_table "novels", force: :cascade do |t|
    t.string "title"
    t.string "catchphrase"
    t.text "outline"
    t.bigint "user_id"
    t.bigint "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "keyword_one"
    t.string "keyword_two"
    t.string "keyword_three"
    t.string "keyword_four"
    t.string "keyword_five"
    t.string "image"
    t.index ["genre_id"], name: "index_novels_on_genre_id"
    t.index ["user_id", "created_at", "genre_id"], name: "index_novels_on_user_id_and_created_at_and_genre_id"
    t.index ["user_id"], name: "index_novels_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.bigint "novel_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["novel_id", "created_at", "user_id"], name: "index_reviews_on_novel_id_and_created_at_and_user_id"
    t.index ["novel_id"], name: "index_reviews_on_novel_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.bigint "novel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["novel_id", "created_at"], name: "index_stories_on_novel_id_and_created_at"
    t.index ["novel_id"], name: "index_stories_on_novel_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "field"
    t.string "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "lastaccesstime", default: "2019-08-28 08:37:28"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "admin", default: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "favorites", "novels"
  add_foreign_key "favorites", "users"
  add_foreign_key "notes", "users"
  add_foreign_key "novel_tag_relations", "novels"
  add_foreign_key "novel_tag_relations", "tags"
  add_foreign_key "novels", "genres"
  add_foreign_key "novels", "users"
  add_foreign_key "reviews", "novels"
  add_foreign_key "reviews", "users"
  add_foreign_key "stories", "novels"
end
