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

ActiveRecord::Schema.define(version: 20170324011548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "home_types", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "home_viewers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "home_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "home_viewers", ["user_id", "home_id"], name: "index_home_viewers_on_user_id_and_home_id", unique: true, using: :btree

  create_table "homes", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "name",                         null: false
    t.integer  "owner_id",                     null: false
    t.boolean  "is_public",    default: false, null: false
    t.integer  "home_type_id"
  end

  add_index "homes", ["name"], name: "index_homes_on_name", using: :btree
  add_index "homes", ["owner_id"], name: "index_homes_on_owner_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "node_id"
    t.string   "message_type"
    t.integer  "child_sensor_id"
    t.integer  "ack"
    t.integer  "sub_type"
    t.text     "payload"
    t.integer  "sensor_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["sensor_id"], name: "index_messages_on_sensor_id", using: :btree

  create_table "mqtt_users", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "username"
    t.string   "password"
    t.datetime "provisioned_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "old_readings", force: :cascade do |t|
    t.integer  "sensor_id"
    t.text     "key"
    t.float    "value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "message_type"
    t.integer  "child_sensor_id"
    t.integer  "ack"
    t.integer  "sub_type"
  end

  create_table "readings", force: :cascade do |t|
    t.integer  "room_id",    null: false
    t.text     "key",        null: false
    t.float    "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "readings", ["room_id"], name: "index_readings_on_room_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "friendly_name", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "room_types", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "home_id",      null: false
    t.text     "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "room_type_id"
  end

  add_index "rooms", ["home_id"], name: "index_rooms_on_home_id", using: :btree
  add_index "rooms", ["name"], name: "index_rooms_on_name", using: :btree

  create_table "sensors", force: :cascade do |t|
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "node_id",    null: false
    t.integer  "home_id",    null: false
  end

  add_index "sensors", ["node_id"], name: "index_sensors_on_node_id", using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "role_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "home_viewers", "homes"
  add_foreign_key "home_viewers", "users"
  add_foreign_key "homes", "home_types"
  add_foreign_key "homes", "users", column: "owner_id"
  add_foreign_key "messages", "sensors"
  add_foreign_key "mqtt_users", "users"
  add_foreign_key "readings", "rooms"
  add_foreign_key "rooms", "room_types"
  add_foreign_key "sensors", "homes"
  add_foreign_key "sensors", "rooms"
end
