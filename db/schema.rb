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

ActiveRecord::Schema.define(version: 20151222154449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reservation_table_audits", force: :cascade do |t|
    t.integer  "reservation_id"
    t.integer  "table_id"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "reservation_table_audits", ["reservation_id"], name: "index_reservation_table_audits_on_reservation_id", using: :btree
  add_index "reservation_table_audits", ["table_id"], name: "index_reservation_table_audits_on_table_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.string   "name"
    t.integer  "diners"
    t.datetime "time"
    t.integer  "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reservations", ["table_id"], name: "index_reservations_on_table_id", using: :btree

  create_table "tables", force: :cascade do |t|
    t.integer  "capacity"
    t.integer  "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "reservation_table_audits", "reservations"
  add_foreign_key "reservation_table_audits", "tables"
  add_foreign_key "reservations", "tables"
end
