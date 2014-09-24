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

ActiveRecord::Schema.define(version: 20140924084052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "core_standards", force: true do |t|
    t.string "standard_type", null: false
    t.string "dot_notation",  null: false
    t.string "uri",           null: false
    t.string "guid",          null: false
    t.text   "description",   null: false
  end

  create_table "core_standards_lesson_plans", id: false, force: true do |t|
    t.integer "core_standard_id"
    t.integer "lesson_plan_id"
  end

  add_index "core_standards_lesson_plans", ["core_standard_id"], name: "index_core_standards_lesson_plans_on_core_standard_id", using: :btree
  add_index "core_standards_lesson_plans", ["lesson_plan_id"], name: "index_core_standards_lesson_plans_on_lesson_plan_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    null: false
  end

  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "lesson_plans", force: true do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                    null: false
    t.text     "body",       default: ""
    t.string   "course",     default: ""
    t.boolean  "complete",   default: false
  end

  add_index "lesson_plans", ["course"], name: "index_lesson_plans_on_course", using: :btree
  add_index "lesson_plans", ["start"], name: "index_lesson_plans_on_start", using: :btree
  add_index "lesson_plans", ["user_id"], name: "index_lesson_plans_on_user_id", using: :btree

  create_table "to_dos", force: true do |t|
    t.string   "body"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    null: false
  end

  add_index "to_dos", ["user_id"], name: "index_to_dos_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",                 default: false
    t.string   "name",                                   null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
