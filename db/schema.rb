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

ActiveRecord::Schema.define(version: 20150523113529) do

  create_table "articles", force: :cascade do |t|
    t.integer  "hobby_first"
    t.integer  "hobby_second"
    t.integer  "hobby_third"
    t.integer  "hobby_fourth"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "hobbies", force: :cascade do |t|
    t.string   "name"
    t.string   "text"
    t.binary   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "idfs", force: :cascade do |t|
    t.string   "prop"
    t.decimal  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "keywords", ["property_id"], name: "index_keywords_on_property_id"

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tfs", force: :cascade do |t|
    t.string   "prop"
    t.decimal  "value"
    t.integer  "hobby_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tfs", ["hobby_id"], name: "index_tfs_on_hobby_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.binary   "image"
    t.string   "token"
    t.string   "salt"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
