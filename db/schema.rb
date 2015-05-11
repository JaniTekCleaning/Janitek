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

ActiveRecord::Schema.define(version: 20150505225125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_logs", force: :cascade do |t|
    t.string   "controller", limit: 255
    t.string   "action",     limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "action_logs", ["user_id"], name: "index_action_logs_on_user_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "number",            limit: 255
    t.string   "email",             limit: 255, null: false
    t.text     "hot_button_items"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "staff_id"
    t.string   "directnumber",      limit: 255
    t.string   "street1",           limit: 255
    t.string   "street2",           limit: 255
    t.string   "city",              limit: 255
    t.string   "state",             limit: 255
    t.string   "zip",               limit: 255
    t.text     "notes"
    t.string   "contact",           limit: 255
    t.string   "contacttitle",      limit: 255
  end

  add_index "clients", ["staff_id"], name: "index_clients_on_staff_id", using: :btree

  create_table "links", force: :cascade do |t|
    t.string   "url",             limit: 255
    t.integer  "client_id"
    t.string   "type",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "s3_file_name",    limit: 255
    t.string   "s3_content_type", limit: 255
    t.integer  "s3_file_size"
    t.datetime "s3_updated_at"
  end

  add_index "links", ["client_id"], name: "index_links_on_client_id", using: :btree

  create_table "service_requests", force: :cascade do |t|
    t.text     "fields",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version_number"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "force_password_reset",               default: false, null: false
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",                    default: 0,     null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.string   "type",                   limit: 255
    t.boolean  "admin"
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "office",                 limit: 255
    t.text     "description"
    t.string   "title",                  limit: 255
    t.string   "cell",                   limit: 255
  end

  add_index "users", ["client_id"], name: "index_users_on_client_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
