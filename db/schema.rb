# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_23_202051) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.decimal "unit_price"
    t.integer "max_unit_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "subscription_id", null: false
    t.bigint "plan_id", null: false
    t.string "stripe_invoice_id"
    t.integer "total_amount"
    t.string "status"
    t.date "billing_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_invoices_on_buyer_id"
    t.index ["plan_id"], name: "index_invoices_on_plan_id"
    t.index ["subscription_id"], name: "index_invoices_on_subscription_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "plan_id", null: false
    t.decimal "amount"
    t.string "status"
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_payments_on_buyer_id"
    t.index ["plan_id"], name: "index_payments_on_plan_id"
  end

  create_table "plan_features", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "feature_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_plan_features_on_feature_id"
    t.index ["plan_id"], name: "index_plan_features_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "monthly_fee"
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_plans_on_admin_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "plan_id", null: false
    t.integer "billing_day"
    t.boolean "active"
    t.string "default"
    t.string "true"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_subscriptions_on_buyer_id"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
  end

  create_table "usages", force: :cascade do |t|
    t.bigint "feature_id", null: false
    t.integer "units_used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "buyer_id", null: false
    t.bigint "subscription_id", null: false
    t.index ["buyer_id"], name: "index_usages_on_buyer_id"
    t.index ["feature_id"], name: "index_usages_on_feature_id"
    t.index ["subscription_id"], name: "index_usages_on_subscription_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "invoices", "plans"
  add_foreign_key "invoices", "subscriptions"
  add_foreign_key "invoices", "users", column: "buyer_id"
  add_foreign_key "payments", "plans"
  add_foreign_key "payments", "users", column: "buyer_id"
  add_foreign_key "plan_features", "features"
  add_foreign_key "plan_features", "plans"
  add_foreign_key "plans", "users", column: "admin_id"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users", column: "buyer_id"
  add_foreign_key "usages", "features"
  add_foreign_key "usages", "subscriptions"
  add_foreign_key "usages", "users", column: "buyer_id"
end
