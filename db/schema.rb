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

ActiveRecord::Schema.define(version: 2019_03_21_123920) do

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36
    t.string "name"
    t.text "description"
    t.integer "projects_count", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
    t.index ["uuid"], name: "index_clients_on_uuid"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "order_id", limit: 50
    t.integer "status", limit: 1, default: 1
    t.integer "track_id"
    t.string "payment_id", limit: 50
    t.integer "amount"
    t.string "card_no", limit: 16
    t.timestamp "payment_date"
    t.timestamp "expired_at", default: "2019-03-23 09:56:50"
    t.timestamp "verified_at"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["payment_id"], name: "index_payments_on_payment_id"
    t.index ["status"], name: "index_payments_on_status"
    t.index ["track_id"], name: "index_payments_on_track_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "cost", precision: 10, scale: 2
    t.decimal "budget", precision: 15, scale: 2
    t.integer "budget_type", limit: 1, default: 0
    t.integer "saats_count", default: 0
    t.integer "status", limit: 1, default: 0
    t.string "uuid", limit: 36
    t.string "name"
    t.string "color", limit: 6, default: "81e9b5"
    t.text "description"
    t.bigint "user_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["name"], name: "index_projects_on_name"
    t.index ["user_id"], name: "index_projects_on_user_id"
    t.index ["uuid"], name: "index_projects_on_uuid"
  end

  create_table "saats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36
    t.decimal "duration", precision: 10, scale: 2
    t.timestamp "start"
    t.timestamp "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "client_id"
    t.bigint "project_id"
    t.index ["client_id"], name: "index_saats_on_client_id"
    t.index ["duration"], name: "index_saats_on_duration"
    t.index ["end"], name: "index_saats_on_end"
    t.index ["project_id"], name: "index_saats_on_project_id"
    t.index ["start"], name: "index_saats_on_start"
    t.index ["user_id"], name: "index_saats_on_user_id"
    t.index ["uuid"], name: "index_saats_on_uuid"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "email"
    t.string "password"
    t.string "zone", limit: 50, default: "Tehran"
    t.integer "status", limit: 1, default: 0
    t.integer "is_admin", limit: 1, default: 0
    t.integer "plan", limit: 1, default: 0
    t.integer "projects_count", default: 0
    t.integer "clients_count", default: 0
    t.timestamp "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "clients", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "projects", "clients"
  add_foreign_key "projects", "users"
  add_foreign_key "saats", "clients"
  add_foreign_key "saats", "projects"
  add_foreign_key "saats", "users"
end
