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

ActiveRecord::Schema[7.0].define(version: 2022_10_10_051938) do
  create_table "campaigns", force: :cascade do |t|
    t.string "source"
    t.string "medium"
    t.string "name"
    t.string "term"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "url_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_campaigns_on_deleted_at"
    t.index ["url_id"], name: "index_campaigns_on_url_id"
  end

  create_table "click_logs", force: :cascade do |t|
    t.integer "url_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url_id"], name: "index_click_logs_on_url_id"
  end

  create_table "sites", force: :cascade do |t|
    t.text "url"
    t.string "shortener"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sites_on_user_id"
  end

  create_table "urls", force: :cascade do |t|
    t.text "page"
    t.string "shortener"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "utm_url"
    t.integer "click", default: 0
    t.integer "click_logs_count"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_urls_on_deleted_at"
    t.index ["user_id"], name: "index_urls_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "click_logs", "urls"
  add_foreign_key "sites", "users"
  add_foreign_key "urls", "users"
end
