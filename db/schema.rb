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

ActiveRecord::Schema.define(version: 20150417053134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "building_name"
    t.string   "street_address"
    t.string   "room"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_categories", force: true do |t|
    t.string   "category_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_hosts", force: true do |t|
    t.string   "host_name"
    t.text     "description"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_times", force: true do |t|
    t.integer  "event_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_times", ["event_id"], name: "index_event_times_on_event_id", using: :btree

  create_table "event_to_event_categories_tables", force: true do |t|
    t.integer  "event_id"
    t.integer  "event_category_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "event_to_event_categories_tables", ["event_category_id"], name: "index_event_to_event_categories_tables_on_event_category_id", using: :btree
  add_index "event_to_event_categories_tables", ["event_id"], name: "index_event_to_event_categories_tables_on_event_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "university_id"
    t.text     "description"
    t.string   "department"
    t.text     "website"
    t.integer  "address_id"
  end

  add_index "events", ["address_id"], name: "index_events_on_address_id", using: :btree
  add_index "events", ["university_id"], name: "index_events_on_university_id", using: :btree

  create_table "events_to_event_categories", force: true do |t|
    t.integer  "event_id"
    t.integer  "event_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events_to_event_categories", ["event_category_id"], name: "index_events_to_event_categories_on_event_category_id", using: :btree
  add_index "events_to_event_categories", ["event_id"], name: "index_events_to_event_categories_on_event_id", using: :btree

  create_table "job_info_sessions", force: true do |t|
    t.string   "employer"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "website"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "education_level"
    t.string   "student_type"
    t.string   "faculties"
    t.string   "location"
  end

  create_table "universities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
