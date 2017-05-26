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

ActiveRecord::Schema.define(version: 20170524205851) do

  create_table "administrative_assistants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_administrative_assistants_on_user_id", using: :btree
  end

  create_table "allocations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "active"
    t.time     "start_time"
    t.time     "final_time"
    t.string   "day"
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "school_room_id"
    t.index ["room_id"], name: "index_allocations_on_room_id", using: :btree
    t.index ["school_room_id"], name: "index_allocations_on_school_room_id", using: :btree
    t.index ["user_id"], name: "index_allocations_on_user_id", using: :btree
  end

  create_table "buildings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.string   "wing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_rooms", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "category_id", null: false
    t.integer "room_id",     null: false
    t.index ["category_id", "room_id"], name: "index_categories_rooms_on_category_id_and_room_id", using: :btree
    t.index ["room_id", "category_id"], name: "index_categories_rooms_on_room_id_and_category_id", using: :btree
  end

  create_table "categories_school_rooms", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "category_id",    null: false
    t.integer "school_room_id", null: false
    t.index ["category_id", "school_room_id"], name: "index_categories_school_rooms_on_category_id_and_school_room_id", using: :btree
    t.index ["school_room_id", "category_id"], name: "index_categories_school_rooms_on_school_room_id_and_category_id", using: :btree
  end

  create_table "coordinators", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_coordinators_on_course_id", using: :btree
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

  create_table "courses_school_rooms", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "course_id",      null: false
    t.integer "school_room_id", null: false
    t.index ["course_id", "school_room_id"], name: "index_courses_school_rooms_on_course_id_and_school_room_id", using: :btree
    t.index ["school_room_id", "course_id"], name: "index_courses_school_rooms_on_school_room_id_and_course_id", using: :btree
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

  create_table "periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "initial_date"
    t.datetime "final_date"
    t.string   "period_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "capacity"
    t.boolean  "active"
    t.integer  "time_grid_id"
    t.integer  "actual_capacity"
    t.integer  "department_id"
    t.integer  "building_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["building_id"], name: "index_rooms_on_building_id", using: :btree
    t.index ["department_id"], name: "index_rooms_on_department_id", using: :btree
  end

  create_table "school_rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "vacancies"
    t.integer  "discipline_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["discipline_id"], name: "index_school_rooms_on_discipline_id", using: :btree
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
  add_foreign_key "allocations", "rooms"
  add_foreign_key "allocations", "school_rooms"
  add_foreign_key "allocations", "users"
  add_foreign_key "coordinators", "courses"
  add_foreign_key "coordinators", "users"
  add_foreign_key "courses", "departments"
  add_foreign_key "department_assistants", "departments"
  add_foreign_key "department_assistants", "users"
  add_foreign_key "disciplines", "departments"
  add_foreign_key "rooms", "departments"
  add_foreign_key "school_rooms", "disciplines"
end
