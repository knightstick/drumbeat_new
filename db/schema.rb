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

ActiveRecord::Schema.define(version: 20140925052734) do

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.string   "sticking"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
    t.integer  "tier"
  end

  create_table "scorecards", force: true do |t|
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.integer  "score4"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score60"
    t.integer  "score5"
  end

  add_index "scorecards", ["exercise_id"], name: "index_scorecards_on_exercise_id"
  add_index "scorecards", ["user_id"], name: "index_scorecards_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "name"
    t.integer  "daily_exercise"
    t.datetime "daily_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
