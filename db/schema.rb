# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_15_060903) do

  create_table "content_bookmarks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "content_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_content_bookmarks_on_content_id"
    t.index ["user_id"], name: "index_content_bookmarks_on_user_id"
  end

  create_table "contents", force: :cascade do |t|
    t.integer "user_id"
    t.text "title"
    t.integer "emotions"
    t.integer "score"
    t.text "journaling"
    t.text "situation"
    t.text "compassion"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "mind"
    t.text "reason"
    t.text "small_success"
    t.text "small_thanks"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "memos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "type"
    t.text "tytle"
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "age"
    t.integer "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "content_bookmarks", "contents"
  add_foreign_key "content_bookmarks", "users"
end
