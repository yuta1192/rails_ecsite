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

ActiveRecord::Schema.define(version: 2019_12_20_031834) do

  create_table "cart_items", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.integer "num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "delivery_date"
    t.integer "delivery_zone"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.string "good_job"
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "evaluation"
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_favorites_on_product_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_purchase_shipments", force: :cascade do |t|
    t.integer "product_purchase_id"
    t.integer "shipment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_purchase_id"], name: "index_product_purchase_shipments_on_product_purchase_id"
    t.index ["shipment_id"], name: "index_product_purchase_shipments_on_shipment_id"
  end

  create_table "product_purchases", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.integer "num"
    t.string "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shipping_zip_code"
    t.string "shipping_prefectures"
    t.string "shipping_address"
    t.date "delivery_date"
    t.integer "delivery_zone"
    t.boolean "finish_flag", default: false, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.string "image"
    t.integer "stock", default: 0, null: false
    t.string "designer", default: "unknown", null: false
    t.boolean "sale", default: false, null: false
    t.string "size", default: "M", null: false
  end

  create_table "rankings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "tel"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false, null: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.integer "prefectures"
    t.string "zip_code"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
