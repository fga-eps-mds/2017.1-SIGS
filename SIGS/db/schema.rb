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

ActiveRecord::Schema.define(version: 20170418005650) do

  create_table "administrative_assistants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_administrative_assistants_on_user_id", using: :btree
  end

  create_table "buildings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.string   "wing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coordinators", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "department_id"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id"], name: "index_coordinators_on_course_id", using: :btree
    t.index ["department_id"], name: "index_coordinators_on_department_id", using: :btree
    t.index ["user_id"], name: "index_coordinators_on_user_id", using: :btree
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "shift"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_courses_on_department_id", using: :btree
  end

  create_table "department_assistants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "department_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_department_assistants_on_department_id", using: :btree
    t.index ["user_id"], name: "index_department_assistants_on_user_id", using: :btree
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.string   "acronym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_disciplines_on_department_id", using: :btree
  end

  create_table "parsers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "capacity"
    t.boolean  "active"
    t.integer  "time_grid_id"
    t.integer  "building_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["building_id"], name: "index_rooms_on_building_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cpf"
    t.string   "registration"
    t.boolean  "active"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_foreign_key "administrative_assistants", "users"
  add_foreign_key "coordinators", "courses"
  add_foreign_key "coordinators", "departments"
  add_foreign_key "coordinators", "users"
  add_foreign_key "courses", "departments"
  add_foreign_key "department_assistants", "departments"
  add_foreign_key "department_assistants", "users"
  add_foreign_key "disciplines", "departments"
end
