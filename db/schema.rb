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

ActiveRecord::Schema.define(version: 20160113203237) do

  create_table "keywords", force: :cascade do |t|
    t.integer  "report_id"
    t.string   "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "keywords", ["report_id"], name: "index_keywords_on_report_id"

  create_table "occupations", force: :cascade do |t|
    t.integer  "keyword_id"
    t.boolean  "selected"
    t.integer  "soc_occupation_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.boolean  "accepted"
  end

  add_index "occupations", ["keyword_id"], name: "index_occupations_on_keyword_id"
  add_index "occupations", ["soc_occupation_id"], name: "index_occupations_on_soc_occupation_id"

  create_table "reports", force: :cascade do |t|
    t.string   "guid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "soc_occupations", force: :cascade do |t|
    t.integer  "soc_code"
    t.string   "title"
    t.text     "description"
    t.text     "tasks"
    t.text     "qualifications"
    t.text     "additional_titles"
    t.integer  "week_hours"
    t.integer  "week_pay"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
