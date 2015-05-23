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

ActiveRecord::Schema.define(version: 20150522184636) do

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

  create_table "files", force: :cascade do |t|
    t.integer  "image_id"
    t.string   "style"
    t.binary   "file_contents"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "menu_item_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "images", ["menu_item_id"], name: "index_images_on_menu_item_id", using: :btree

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

  create_table "menu_items_menus", id: false, force: :cascade do |t|
    t.integer "menu_id"
    t.integer "menu_item_id"
  end

  add_index "menu_items_menus", ["menu_id", "menu_item_id"], name: "index_menu_items_menus_on_menu_id_and_menu_item_id", unique: true, using: :btree
  add_index "menu_items_menus", ["menu_id"], name: "index_menu_items_menus_on_menu_id", using: :btree
  add_index "menu_items_menus", ["menu_item_id"], name: "index_menu_items_menus_on_menu_item_id", using: :btree

  create_table "menu_items_orders", force: :cascade do |t|
    t.integer "order_id"
    t.integer "menu_item_id"
  end

  add_index "menu_items_orders", ["menu_item_id"], name: "index_menu_items_orders_on_menu_item_id", using: :btree
  add_index "menu_items_orders", ["order_id"], name: "index_menu_items_orders_on_order_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.boolean  "show_category"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "title"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status",           default: "pending", null: false
    t.datetime "order_time"
    t.datetime "pickup_time"
    t.datetime "fulfillment_time"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_admin"
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "images", "menu_items"
end
