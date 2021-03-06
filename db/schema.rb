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

ActiveRecord::Schema.define(version: 20180313212304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_logs", force: :cascade do |t|
    t.string   "controller"
    t.string   "action"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "action_logs", ["user_id"], name: "index_action_logs_on_user_id", using: :btree

  create_table "buildings", force: :cascade do |t|
    t.integer "client_id"
    t.string  "name"
    t.string  "number"
    t.string  "email"
    t.text    "hot_button_items"
    t.integer "staff_id"
    t.string  "directnumber"
    t.string  "street1"
    t.string  "street2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.text    "notes"
    t.string  "contact"
    t.string  "contacttitle"
    t.string  "billing_street_1"
    t.string  "billing_street_2"
    t.string  "billing_city"
    t.string  "billing_state"
    t.string  "billing_zip"
    t.text    "last_service_request"
  end

  add_index "buildings", ["client_id"], name: "index_buildings_on_client_id", using: :btree

  create_table "buildings_members", force: :cascade do |t|
    t.integer "building_id"
    t.integer "member_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.string   "email",             null: false
    t.text     "hot_button_items"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "staff_id"
    t.string   "directnumber"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "notes"
    t.string   "contact"
    t.string   "contacttitle"
    t.string   "billing_street_1"
    t.string   "billing_street_2"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_zip"
  end

  add_index "clients", ["staff_id"], name: "index_clients_on_staff_id", using: :btree

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "s3_file_name"
    t.string   "s3_content_type"
    t.integer  "s3_file_size"
    t.datetime "s3_updated_at"
    t.text     "title"
    t.integer  "building_id"
  end

  create_table "service_requests", force: :cascade do |t|
    t.text     "fields",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version_number"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "force_password_reset",   default: false, null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.string   "type"
    t.boolean  "admin"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "office"
    t.text     "description"
    t.string   "title"
    t.string   "cell"
  end

  add_index "users", ["client_id"], name: "index_users_on_client_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "buildings", "clients"
  add_foreign_key "buildings", "users", column: "staff_id"
  add_foreign_key "buildings_members", "users", column: "member_id"
end
