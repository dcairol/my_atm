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

ActiveRecord::Schema.define(version: 20141208022007) do

  create_table "bank_accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "currency_id"
    t.integer  "number"
    t.integer  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: true do |t|
    t.integer  "bank_account_id"
    t.integer  "pin"
    t.string   "card_type"
    t.integer  "number"
    t.date     "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string   "currency"
    t.float    "exchange_rate"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
