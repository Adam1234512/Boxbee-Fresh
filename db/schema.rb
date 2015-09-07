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

ActiveRecord::Schema.define(version: 20150907014135) do

  create_table "beta_surveys", force: :cascade do |t|
    t.boolean  "currently_offer_storage"
    t.boolean  "offer_transport"
    t.string   "company_name"
    t.string   "company_website"
    t.string   "name"
    t.string   "preferred_contact_method"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.text     "how_manage_warehouse",     default: "--- []\n"
    t.text     "how_manage_vehicles",      default: "--- []\n"
    t.text     "how_bookings_done",        default: "--- []\n"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "state"
    t.string   "country"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cities", ["company_id"], name: "index_cities_on_company_id"

  create_table "claims", force: :cascade do |t|
    t.boolean  "successfully_claimed"
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "claims", ["company_id"], name: "index_claims_on_company_id"
  add_index "claims", ["user_id"], name: "index_claims_on_user_id"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "zip"
    t.string   "website_url"
    t.text     "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
    t.integer  "guest_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "companies", ["guest_id"], name: "index_companies_on_guest_id"
  add_index "companies", ["user_id"], name: "index_companies_on_user_id"

  create_table "guests", force: :cascade do |t|
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
