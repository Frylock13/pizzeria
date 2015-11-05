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

ActiveRecord::Schema.define(version: 20151105140534) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "street",        limit: 50
    t.string   "house",         limit: 10
    t.string   "flat",          limit: 10
    t.string   "floor",         limit: 10
    t.string   "intercom_code", limit: 10
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "addresses", ["owner_id"], name: "index_addresses_on_owner_id", using: :btree

  create_table "dough_attributes", force: :cascade do |t|
    t.integer  "dough_id"
    t.integer  "pizza_size"
    t.decimal  "price",      precision: 15, scale: 2
    t.integer  "weight"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "dough_attributes", ["dough_id"], name: "index_dough_attributes_on_dough_id", using: :btree

  create_table "doughs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feature_values", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredient_attributes", force: :cascade do |t|
    t.integer  "ingredient_id"
    t.integer  "pizza_size"
    t.decimal  "price",         precision: 15, scale: 2
    t.integer  "weight"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "ingredient_attributes", ["ingredient_id"], name: "index_ingredient_attributes_on_ingredient_id", using: :btree

  create_table "ingredient_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.integer  "ingredient_category_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "ingredients", ["ingredient_category_id"], name: "index_ingredients_on_ingredient_category_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "address_id"
    t.integer  "status"
    t.text     "wishes"
    t.integer  "receiving_profile_id"
    t.integer  "ordering_profile_id"
    t.integer  "payment_method"
    t.datetime "booked_on"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "orders", ["address_id"], name: "index_orders_on_address_id", using: :btree
  add_index "orders", ["ordering_profile_id"], name: "index_orders_on_ordering_profile_id", using: :btree
  add_index "orders", ["payment_method"], name: "index_orders_on_payment_method", using: :btree
  add_index "orders", ["receiving_profile_id"], name: "index_orders_on_receiving_profile_id", using: :btree
  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pizza_attributes", force: :cascade do |t|
    t.integer  "pizza_id"
    t.integer  "pizza_size"
    t.decimal  "price",      precision: 15, scale: 2
    t.integer  "weight"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "pizza_attributes", ["pizza_id"], name: "index_pizza_attributes_on_pizza_id", using: :btree

  create_table "pizza_ingredients", force: :cascade do |t|
    t.integer  "pizza_id"
    t.integer  "ingredient_id"
    t.integer  "quantity",      default: 1
    t.boolean  "core",          default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "pizza_ingredients", ["ingredient_id"], name: "index_pizza_ingredients_on_ingredient_id", using: :btree
  add_index "pizza_ingredients", ["pizza_id"], name: "index_pizza_ingredients_on_pizza_id", using: :btree

  create_table "pizzas", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "visibility", default: 0
    t.integer  "user_id"
    t.integer  "dough_id"
    t.integer  "parent_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "pizzas", ["dough_id"], name: "index_pizzas_on_dough_id", using: :btree
  add_index "pizzas", ["user_id"], name: "index_pizzas_on_user_id", using: :btree

  create_table "product_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_features", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "feature_id"
    t.integer  "feature_value_id"
    t.decimal  "price",            precision: 15, scale: 2
    t.integer  "weight"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "product_features", ["feature_id"], name: "index_product_features_on_feature_id", using: :btree
  add_index "product_features", ["feature_value_id"], name: "index_product_features_on_feature_value_id", using: :btree
  add_index "product_features", ["product_id", "feature_id", "feature_value_id"], name: "index_product_features_compound_key", unique: true, using: :btree
  add_index "product_features", ["product_id"], name: "index_product_features_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.integer  "weight"
    t.decimal  "price",               precision: 15, scale: 2
    t.integer  "product_category_id"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "visibility",                                   default: 0
  end

  add_index "products", ["product_category_id"], name: "index_products_on_product_category_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
    t.string   "email"
    t.integer  "owner_id"
  end

  add_index "profiles", ["email"], name: "index_profiles_on_email", using: :btree
  add_index "profiles", ["owner_id"], name: "index_profiles_on_owner_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                                null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "role",                                                     default: 0
    t.decimal  "bonus_points",                    precision: 15, scale: 2
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  create_table "viewable_resources", force: :cascade do |t|
    t.string   "anchor"
    t.string   "meta_keywords"
    t.string   "meta_title"
    t.text     "page_annotation"
    t.text     "page_description"
    t.string   "page_title"
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "viewable_resources", ["viewable_type", "viewable_id"], name: "index_viewable_resources_on_viewable_type_and_viewable_id", using: :btree

  add_foreign_key "dough_attributes", "doughs"
  add_foreign_key "ingredient_attributes", "ingredients"
  add_foreign_key "ingredients", "ingredient_categories"
  add_foreign_key "orders", "addresses"
  add_foreign_key "pizza_attributes", "pizzas"
  add_foreign_key "pizza_ingredients", "ingredients"
  add_foreign_key "pizza_ingredients", "pizzas"
  add_foreign_key "pizzas", "doughs"
  add_foreign_key "pizzas", "users"
  add_foreign_key "product_features", "feature_values"
  add_foreign_key "product_features", "features"
  add_foreign_key "product_features", "products"
  add_foreign_key "products", "product_categories"
end
