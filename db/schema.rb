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

ActiveRecord::Schema.define(version: 20151103004808) do

  create_table "clients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "billing_address"
    t.string   "job_address"
    t.string   "city"
    t.string   "state"
    t.string(5)   "zip"
    t.money  "balance"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "date"
    t.string   "performed_by"
    t.string   "status"
    t.string   "note"
    t.money  "total"
    t.integer  "client_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id"

  create_table "recurring_prices", force: :cascade do |t|
    t.string   "name"
    t.money  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client_id"
  end

  add_index "recurring_prices", ["client_id"], name: "index_recurring_prices_on_client_id"

  create_table "recurring_services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "quantity"
    t.money  "price"
    t.integer  "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client_id"
  end

  add_index "services", ["client_id"], name: "index_services_on_client_id"
  add_index "services", ["invoice_id"], name: "index_services_on_invoice_id"

end
