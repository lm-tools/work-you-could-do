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

ActiveRecord::Schema.define(version: 20160215133017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "occupations", force: :cascade do |t|
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

  add_index "occupations", ["soc_code"], name: "index_occupations_on_soc_code", unique: true, using: :btree

  create_table "saved_occupations", id: false, force: :cascade do |t|
    t.integer "occupation_id"
    t.integer "scrapbook_id"
  end

  add_index "saved_occupations", ["occupation_id", "scrapbook_id"], name: "index_saved_occupations_on_occupation_id_and_scrapbook_id", unique: true, using: :btree
  add_index "saved_occupations", ["occupation_id"], name: "index_saved_occupations_on_occupation_id", using: :btree
  add_index "saved_occupations", ["scrapbook_id"], name: "index_saved_occupations_on_scrapbook_id", using: :btree

  create_table "scrapbooks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
