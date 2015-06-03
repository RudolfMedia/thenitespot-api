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

ActiveRecord::Schema.define(version: 20150603000458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "sort"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorizations", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "categorizable_id"
    t.string   "categorizable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "categorizations", ["categorizable_id"], name: "index_categorizations_on_categorizable_id", using: :btree
  add_index "categorizations", ["categorizable_type"], name: "index_categorizations_on_categorizable_type", using: :btree
  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "spot_id"
    t.string   "name"
    t.string   "slug"
    t.text     "about"
    t.string   "age"
    t.string   "entry"
    t.string   "entry_fee"
    t.string   "phone"
    t.string   "email"
    t.string   "ticket_url"
    t.string   "website_url"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree
  add_index "events", ["spot_id"], name: "index_events_on_spot_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["spot_id"], name: "index_favorites_on_spot_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hours", force: :cascade do |t|
    t.integer  "spot_id"
    t.time     "open",                    null: false
    t.time     "close",                   null: false
    t.string   "days",       default: [],              array: true
    t.string   "note"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "hours", ["spot_id"], name: "index_hours_on_spot_id", using: :btree

  create_table "menu_items", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "menu_items", ["menu_id"], name: "index_menu_items_on_menu_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.integer  "spot_id"
    t.integer  "sort"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "menus", ["sort"], name: "index_menus_on_sort", using: :btree
  add_index "menus", ["spot_id"], name: "index_menus_on_spot_id", using: :btree

  create_table "neighborhoods", force: :cascade do |t|
    t.string   "name"
    t.string   "label"
    t.string   "state"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "spots_count", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "occurrences", force: :cascade do |t|
    t.integer  "event_id"
    t.date     "start_date",      null: false
    t.time     "start_time"
    t.date     "end_date"
    t.time     "end_time"
    t.date     "expiration_date", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "occurrences", ["event_id"], name: "index_occurrences_on_event_id", using: :btree
  add_index "occurrences", ["expiration_date"], name: "index_occurrences_on_expiration_date", using: :btree
  add_index "occurrences", ["start_date"], name: "index_occurrences_on_start_date", using: :btree

  create_table "specials", force: :cascade do |t|
    t.integer  "spot_id"
    t.string   "name"
    t.integer  "sort"
    t.string   "description"
    t.string   "days",        default: [],              array: true
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "specials", ["sort"], name: "index_specials_on_sort", using: :btree
  add_index "specials", ["spot_id"], name: "index_specials_on_spot_id", using: :btree

  create_table "spot_features", force: :cascade do |t|
    t.integer  "spot_id"
    t.integer  "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "spot_features", ["feature_id"], name: "index_spot_features_on_feature_id", using: :btree
  add_index "spot_features", ["spot_id"], name: "index_spot_features_on_spot_id", using: :btree

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
    t.integer  "neighborhood_id"
  end

  add_index "spots", ["attend"], name: "index_spots_on_attend", using: :btree
  add_index "spots", ["drink"], name: "index_spots_on_drink", using: :btree
  add_index "spots", ["eat"], name: "index_spots_on_eat", using: :btree
  add_index "spots", ["latitude"], name: "index_spots_on_latitude", using: :btree
  add_index "spots", ["longitude"], name: "index_spots_on_longitude", using: :btree
  add_index "spots", ["neighborhood_id"], name: "index_spots_on_neighborhood_id", using: :btree
  add_index "spots", ["slug"], name: "index_spots_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",                            null: false
    t.string   "uid",                    default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "email"
    t.string   "gender"
    t.date     "dob"
    t.string   "location"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "categorizations", "categories"
  add_foreign_key "events", "spots"
  add_foreign_key "favorites", "spots"
  add_foreign_key "favorites", "users"
  add_foreign_key "hours", "spots"
  add_foreign_key "menu_items", "menus"
  add_foreign_key "menus", "spots"
  add_foreign_key "occurrences", "events"
  add_foreign_key "specials", "spots"
  add_foreign_key "spot_features", "features"
  add_foreign_key "spot_features", "spots"
  add_foreign_key "spots", "neighborhoods"
end
