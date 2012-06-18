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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120618114227) do

  create_table "patients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.date     "dob"
    t.string   "mobile"
    t.string   "sex"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "physician_id"
  end

  add_index "patients", ["first_name"], :name => "index_patients_on_first_name"
  add_index "patients", ["last_name"], :name => "index_patients_on_last_name"

  create_table "physicians", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.date     "dob"
    t.string   "mobile"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "physicians", ["email"], :name => "index_physicians_on_email", :unique => true
  add_index "physicians", ["remember_token"], :name => "index_physicians_on_remember_token"

  create_table "visit_searches", :force => true do |t|
    t.string   "reference_number"
    t.date     "from_date"
    t.date     "to_date"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "keywords"
  end

  create_table "visits", :force => true do |t|
    t.string   "reference_number"
    t.date     "date_of_visit"
    t.text     "complaints"
    t.text     "findings"
    t.text     "treatment"
    t.text     "notes"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "patient_id"
    t.string   "diagnosis"
  end

  add_index "visits", ["complaints"], :name => "index_visits_on_complaints"
  add_index "visits", ["date_of_visit"], :name => "index_visits_on_date_of_visit"
  add_index "visits", ["findings"], :name => "index_visits_on_findings"
  add_index "visits", ["notes"], :name => "index_visits_on_notes"
  add_index "visits", ["reference_number"], :name => "index_visits_on_reference_number"
  add_index "visits", ["treatment"], :name => "index_visits_on_treatment"

end
