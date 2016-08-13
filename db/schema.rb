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

ActiveRecord::Schema.define(version: 20160813173012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "billing_address"
    t.string   "job_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.money    "balance",         scale: 2
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "phone_number"
    t.integer  "cut_order"
  end

  create_table "estimate_items", force: :cascade do |t|
    t.integer  "estimate_id"
    t.string   "name"
    t.money    "price",       scale: 2
    t.integer  "quantity"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "estimate_items", ["estimate_id"], name: "index_estimate_items_on_estimate_id", using: :btree

  create_table "estimates", force: :cascade do |t|
    t.datetime "date"
    t.money    "total",      scale: 2
    t.string   "notes"
    t.integer  "client_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "estimates", ["client_id"], name: "index_estimates_on_client_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.datetime "date"
    t.string   "performed_by"
    t.string   "status"
    t.string   "note"
    t.money    "total",        scale: 2
    t.integer  "client_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.date     "date"
    t.money    "amount",       scale: 2
    t.string   "payment_type"
    t.integer  "invoice_id"
    t.integer  "client_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "payments", ["client_id"], name: "index_payments_on_client_id", using: :btree
  add_index "payments", ["invoice_id"], name: "index_payments_on_invoice_id", using: :btree

  create_table "recurring_prices", force: :cascade do |t|
    t.string   "name"
    t.money    "price",      scale: 2
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "client_id"
  end

  add_index "recurring_prices", ["client_id"], name: "index_recurring_prices_on_client_id", using: :btree

  create_table "recurring_services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "quantity"
    t.money    "price",      scale: 2
    t.integer  "invoice_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "client_id"
  end

  add_index "services", ["client_id"], name: "index_services_on_client_id", using: :btree
  add_index "services", ["invoice_id"], name: "index_services_on_invoice_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "name",                   default: "Name", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "estimate_items", "estimates"
  add_foreign_key "estimates", "clients"
  add_foreign_key "payments", "clients"
  add_foreign_key "payments", "invoices"
  add_foreign_key "services", "invoices"
end
