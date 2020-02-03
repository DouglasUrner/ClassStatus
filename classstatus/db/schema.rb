# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_03_172026) do

  create_table "attendance_records", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "section_id", null: false
    t.date "attendance_date"
    t.datetime "attendance_entered"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_attendance_records_on_section_id"
    t.index ["student_id"], name: "index_attendance_records_on_student_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.string "name"
    t.integer "sort_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "student_id"
    t.integer "section_id"
    t.date "joined_course"
    t.date "joined_section"
    t.date "dropped_course"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_enrollments_on_section_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "year_id", null: false
    t.integer "term_id", null: false
    t.integer "block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["block_id"], name: "index_sections_on_block_id"
    t.index ["course_id"], name: "index_sections_on_course_id"
    t.index ["term_id"], name: "index_sections_on_term_id"
    t.index ["year_id"], name: "index_sections_on_year_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.string "target_type", null: false
    t.integer "target_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true
    t.index ["target_type", "target_id"], name: "index_settings_on_target_type_and_target_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "guid"
    t.string "preferred_name"
    t.string "given_name"
    t.string "family_name"
    t.date "dob"
    t.string "gender"
    t.string "pronouns"
    t.integer "cohort"
    t.float "gpa"
    t.datetime "gpa_updated"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guid"], name: "index_students_on_guid", unique: true
  end

  create_table "term_names", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "terms", force: :cascade do |t|
    t.integer "year_id", null: false
    t.integer "term_name_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["term_name_id"], name: "index_terms_on_term_name_id"
    t.index ["year_id"], name: "index_terms_on_year_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "years", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "attendance_records", "sections"
  add_foreign_key "attendance_records", "students"
  add_foreign_key "sections", "blocks"
  add_foreign_key "sections", "courses"
  add_foreign_key "sections", "terms"
  add_foreign_key "sections", "years"
  add_foreign_key "terms", "term_names"
  add_foreign_key "terms", "years"
end
