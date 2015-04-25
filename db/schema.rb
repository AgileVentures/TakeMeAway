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

ActiveRecord::Schema.define(version: 20150425193211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "menu_items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_items_orders", force: :cascade do |t|
    t.integer "order_id"
    t.integer "menu_item_id"
  end

  add_index "menu_items_orders", ["menu_item_id"], name: "index_menu_items_orders_on_menu_item_id", using: :btree
  add_index "menu_items_orders", ["order_id"], name: "index_menu_items_orders_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status"
    t.datetime "order_time"
    t.datetime "pickup_time"
    t.datetime "fulfillment_time"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
