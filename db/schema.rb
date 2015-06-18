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

ActiveRecord::Schema.define(version: 20150618135438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "attachinary_files", force: :cascade do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "menu_categories", force: :cascade do |t|
    t.string   "name",       limit: 45
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "menu_categories_items", id: false, force: :cascade do |t|
    t.integer "menu_category_id"
    t.integer "menu_item_id"
  end

  add_index "menu_categories_items", ["menu_category_id"], name: "index_menu_categories_items_on_menu_category_id", using: :btree
  add_index "menu_categories_items", ["menu_item_id"], name: "index_menu_categories_items_on_menu_item_id", using: :btree

  create_table "menu_items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.string   "ingredients"
  end

  create_table "menu_items_menus", force: :cascade do |t|
    t.integer "menu_item_id"
    t.integer "menu_id"
    t.integer "daily_stock"
  end

  add_index "menu_items_menus", ["menu_id"], name: "index_menu_items_menus_on_menu_id", using: :btree
  add_index "menu_items_menus", ["menu_item_id"], name: "index_menu_items_menus_on_menu_item_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.boolean  "show_category"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "title"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "menu_item_id"
    t.integer "order_id"
    t.integer "quantity"
    t.integer "menu_id"
  end

  add_index "order_items", ["menu_id"], name: "index_order_items_on_menu_id", using: :btree
  add_index "order_items", ["menu_item_id"], name: "index_order_items_on_menu_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status",           default: "pending", null: false
    t.datetime "order_time"
    t.datetime "pickup_time"
    t.datetime "fulfillment_time"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "amount"
    t.string   "stripe_charge_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_admin",                default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "authentication_token"
    t.boolean  "receive_notifications",   default: false
    t.boolean  "order_acknowledge_email", default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "menu_items_menus", "menu_items"
  add_foreign_key "menu_items_menus", "menus"
  add_foreign_key "order_items", "menu_items"
  add_foreign_key "order_items", "menus"
  add_foreign_key "order_items", "orders"
end
