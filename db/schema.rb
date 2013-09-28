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

ActiveRecord::Schema.define(version: 20130928124006) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_plan_fields", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "lesson_plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lesson_plan_fields", ["lesson_plan_id"], name: "index_lesson_plan_fields_on_lesson_plan_id"

  create_table "lesson_plans", force: true do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "description"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lesson_plans", ["course_id"], name: "index_lesson_plans_on_course_id"
  add_index "lesson_plans", ["start"], name: "index_lesson_plans_on_start"

  create_table "to_dos", force: true do |t|
    t.string   "body"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
