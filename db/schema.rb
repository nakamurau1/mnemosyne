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

ActiveRecord::Schema.define(version: 20190430121004) do

  create_table "decks", force: :cascade do |t|
    t.integer "user_id"
    t.text "title"
    t.text "description"
    t.boolean "public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_decks_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.text "front_text"
    t.text "back_text"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "easiness_factor"
    t.datetime "next_review_datetime"
    t.datetime "previous_review_datetime"
    t.integer "review_count", default: 0
    t.integer "learning_step", default: 1
    t.string "front_picture"
    t.string "back_picture"
    t.integer "deck_id"
    t.index ["deck_id", "created_at"], name: "index_items_on_deck_id_and_created_at"
    t.index ["deck_id"], name: "index_items_on_deck_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "notice"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
