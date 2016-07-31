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

ActiveRecord::Schema.define(version: 20160716183128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_entries", force: :cascade do |t|
    t.integer  "form_id"
    t.jsonb    "inputs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_data_entries_on_form_id", using: :btree
  end

  create_table "form_inputs", force: :cascade do |t|
    t.string   "title"
    t.string   "input_type"
    t.integer  "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_inputs_on_form_id", using: :btree
  end

  create_table "forms", force: :cascade do |t|
    t.string   "name"
    t.boolean  "visible"
    t.string   "public_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forms_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "login_token"
    t.datetime "login_token_valid_until"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_foreign_key "data_entries", "forms"
  add_foreign_key "form_inputs", "forms"
  add_foreign_key "forms", "users"
end
