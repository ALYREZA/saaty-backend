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

ActiveRecord::Schema.define(version: 2019_03_05_180807) do

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "uuid"
    t.integer "projects_count", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
    t.index ["uuid"], name: "index_clients_on_uuid"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.bigint "client_id"
    t.string "uuid"
    t.string "color", limit: 6
    t.integer "saats_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
    t.index ["uuid"], name: "index_projects_on_uuid"
  end

  create_table "saats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.timestamp "value"
    t.bigint "user_id"
    t.bigint "client_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_saats_on_client_id"
    t.index ["project_id"], name: "index_saats_on_project_id"
    t.index ["user_id"], name: "index_saats_on_user_id"
    t.index ["value"], name: "index_saats_on_value"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "zone", limit: 50, default: "Tehran"
    t.integer "status", limit: 1, default: 0
    t.integer "is_admin", limit: 1, default: 0
    t.integer "plan", limit: 1, default: 0
    t.integer "projects_count", default: 0
    t.integer "clients_count", default: 0
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "clients", "users"
  add_foreign_key "projects", "clients"
  add_foreign_key "projects", "users"
  add_foreign_key "saats", "clients"
  add_foreign_key "saats", "projects"
  add_foreign_key "saats", "users"
end
