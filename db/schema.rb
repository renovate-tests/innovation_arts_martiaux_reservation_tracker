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

ActiveRecord::Schema.define(version: 2019_03_03_204643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "age_groups", force: :cascade do |t|
    t.string "name", null: false
    t.integer "min_age", null: false
    t.integer "max_age", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "belts", force: :cascade do |t|
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cash_payments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "due_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "paid", default: false
  end

  create_table "course_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "course_type_id", null: false
    t.integer "timeslot_id", null: false
    t.integer "age_group_id", null: false
    t.integer "number_of_students_allowed"
    t.integer "day_of_week", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["age_group_id"], name: "index_courses_on_age_group_id"
    t.index ["course_type_id"], name: "index_courses_on_course_type_id"
    t.index ["day_of_week"], name: "index_courses_on_day_of_week"
    t.index ["timeslot_id"], name: "index_courses_on_timeslot_id"
  end

  create_table "graduations", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "belt_id", null: false
    t.date "graduation_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["belt_id"], name: "index_graduations_on_belt_id"
    t.index ["student_id"], name: "index_graduations_on_student_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "mail_sent", default: false
    t.index ["course_id"], name: "index_reservations_on_course_id"
    t.index ["mail_sent"], name: "index_reservations_on_mail_sent"
    t.index ["student_id"], name: "index_reservations_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name", null: false
    t.date "date_of_birth"
    t.boolean "active", default: true
    t.integer "user_id", null: false
    t.boolean "uniform_promotion", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "tarifs", force: :cascade do |t|
    t.integer "class_per_week", null: false
    t.float "price", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timeslots", force: :cascade do |t|
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "telephone"
    t.boolean "active", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
