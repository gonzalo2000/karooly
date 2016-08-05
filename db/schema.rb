# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160805185416) do

  create_table "enrollments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "enrollments", ["lesson_id"], name: "index_enrollments_on_lesson_id"
  add_index "enrollments", ["user_id", "lesson_id"], name: "index_enrollments_on_user_id_and_lesson_id"

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "subject"
    t.integer  "difficulty"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id"

  create_table "scrambled_words", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.integer  "word_id"
    t.boolean  "completed",     default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "sequence"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "word_dictations", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.integer  "word_id"
    t.boolean  "completed",     default: false
    t.integer  "sequence"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "word_dictations", ["enrollment_id"], name: "index_word_dictations_on_enrollment_id"
  add_index "word_dictations", ["word_id"], name: "index_word_dictations_on_word_id"

  create_table "word_expositions", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.integer  "word_id"
    t.boolean  "completed",     default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "word_image_matches", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.integer  "word_id"
    t.boolean  "completed",     default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "word_image_matches", ["enrollment_id"], name: "index_word_image_matches_on_enrollment_id"
  add_index "word_image_matches", ["word_id"], name: "index_word_image_matches_on_word_id"

  create_table "words", force: :cascade do |t|
    t.string   "term"
    t.string   "reference"
    t.integer  "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
    t.string   "sound"
  end

  add_index "words", ["lesson_id"], name: "index_words_on_lesson_id"

end
