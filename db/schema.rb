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

ActiveRecord::Schema.define(version: 20130911144743) do

  create_table "answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: true do |t|
    t.string   "file_name"
    t.string   "content_type"
    t.string   "file_size"
    t.string   "attachmentable_type"
    t.integer  "attachmentable_id"
    t.string   "attachment"
    t.boolean  "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_histories", force: true do |t|
    t.string   "area"
    t.string   "ip_address"
    t.string   "action_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "login_histories", ["user_id"], name: "index_login_histories_on_user_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.datetime "reset_password_sent_at"
    t.datetime "locked_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "mobile"
    t.string   "real_name"
    t.string   "google_secret"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
