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

ActiveRecord::Schema.define(version: 20190630081011) do

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "novel_id"
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
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_notes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "novel_tag_relations", force: :cascade do |t|
    t.integer "novel_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["novel_id"], name: "index_novel_tag_relations_on_novel_id"
    t.index ["tag_id"], name: "index_novel_tag_relations_on_tag_id"
  end

  create_table "novels", force: :cascade do |t|
    t.string "title"
    t.string "catchphrase"
    t.text "outline"
    t.integer "user_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "keyword_one"
    t.string "keyword_two"
    t.string "keyword_three"
    t.string "keyword_four"
    t.string "keyword_five"
    t.index ["genre_id"], name: "index_novels_on_genre_id"
    t.index ["user_id", "created_at", "genre_id"], name: "index_novels_on_user_id_and_created_at_and_genre_id"
    t.index ["user_id"], name: "index_novels_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.integer "novel_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["novel_id", "created_at", "user_id"], name: "index_reviews_on_novel_id_and_created_at_and_user_id"
    t.index ["novel_id"], name: "index_reviews_on_novel_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.integer "novel_id"
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
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "field"
    t.string "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
