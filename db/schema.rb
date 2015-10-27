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

ActiveRecord::Schema.define(version: 20151027142225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                       null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "role",                            default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  add_foreign_key "dough_attributes", "doughs"
  add_foreign_key "ingredient_attributes", "ingredients"
  add_foreign_key "ingredients", "ingredient_categories"
  add_foreign_key "pizza_attributes", "pizzas"
  add_foreign_key "pizza_ingredients", "ingredients"
  add_foreign_key "pizza_ingredients", "pizzas"
  add_foreign_key "pizzas", "doughs"
  add_foreign_key "pizzas", "users"
  add_foreign_key "product_features", "feature_values"
  add_foreign_key "product_features", "features"
  add_foreign_key "product_features", "products"
  add_foreign_key "products", "product_categories"
  add_foreign_key "profiles", "users"
end
