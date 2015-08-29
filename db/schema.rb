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

ActiveRecord::Schema.define(version: 20150823231943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", primary_key: "client_id", force: :cascade do |t|
    t.string "first_name",      limit: 80
    t.string "last_name",       limit: 80
    t.string "billing_address", limit: 80
    t.string "job_address",     limit: 80
    t.string "city",            limit: 80
    t.string "state",           limit: 2
    t.string "zip",             limit: 5
    t.money  "cut",                        scale: 2
    t.money  "mulch",                      scale: 2
    t.money  "bush",                       scale: 2
    t.money  "spring",                     scale: 2
    t.money  "fall",                       scale: 2
    t.money  "snow",                       scale: 2
    t.money  "balance",                    scale: 2
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "date"
    t.string   "performed_by"
    t.string   "status"
    t.string   "note"
    t.integer  "client_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "quantity"
    t.integer  "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client_id"
  end

  add_index "services", ["client_id"], name: "index_services_on_client_id", using: :btree
  add_index "services", ["invoice_id"], name: "index_services_on_invoice_id", using: :btree

  add_foreign_key "services", "invoices"
end
