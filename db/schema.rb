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

ActiveRecord::Schema.define(version: 20150528020257) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "spots", force: :cascade do |t|
    t.string   "name",            default: "", null: false
    t.string   "slug"
    t.boolean  "eat"
    t.boolean  "drink"
    t.boolean  "attend"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone"
    t.string   "email"
    t.text     "about"
    t.string   "price"
    t.string   "payment_opts",    default: [],              array: true
    t.string   "website_url"
    t.string   "reservation_url"
    t.string   "menu_url"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "spots", ["attend"], name: "index_spots_on_attend", using: :btree
  add_index "spots", ["drink"], name: "index_spots_on_drink", using: :btree
  add_index "spots", ["eat"], name: "index_spots_on_eat", using: :btree
  add_index "spots", ["latitude"], name: "index_spots_on_latitude", using: :btree
  add_index "spots", ["longitude"], name: "index_spots_on_longitude", using: :btree
  add_index "spots", ["slug"], name: "index_spots_on_slug", unique: true, using: :btree

end
