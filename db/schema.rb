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

ActiveRecord::Schema.define(version: 2019_12_26_074738) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "postcode", null: false
    t.string "city", null: false
    t.string "block", null: false
    t.string "building"
    t.string "tell", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pref_id"
    t.index ["tell"], name: "index_addresses_on_tell", unique: true
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "text", null: false
    t.integer "status", default: 0, null: false
    t.integer "delivery_method", default: 0, null: false
    t.integer "delivery_day", default: 0, null: false
    t.integer "pref", default: 0, null: false
    t.integer "postage_selct", default: 0, null: false
    t.integer "price", null: false
    t.integer "size", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
