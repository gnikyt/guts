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

ActiveRecord::Schema.define(version: 13) do

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "guts_categories", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "metafields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "guts_categories", ["slug"], name: "index_guts_categories_on_slug", unique: true

  create_table "guts_categorizations", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "content_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "guts_contents", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "tags"
    t.text     "content"
    t.integer  "visible",    limit: 1, default: 1
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "type_id"
    t.integer  "user_id"
  end

  add_index "guts_contents", ["slug"], name: "index_guts_contents_on_slug", unique: true
  add_index "guts_contents", ["type_id"], name: "index_guts_contents_on_type_id"
  add_index "guts_contents", ["user_id"], name: "index_guts_contents_on_user_id"

  create_table "guts_groups", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "guts_groups", ["slug"], name: "index_guts_groups_on_slug", unique: true

  create_table "guts_media", force: :cascade do |t|
    t.string   "title"
    t.text     "tags"
    t.integer  "position",          default: 0
    t.integer  "filable_id"
    t.string   "filable_type"
    t.string   "caption"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "guts_media", ["filable_type", "filable_id"], name: "index_guts_media_on_filable_type_and_filable_id"

  create_table "guts_metafields", force: :cascade do |t|
    t.string   "key"
    t.text     "value"
    t.integer  "fieldable_id"
    t.string   "fieldable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "guts_metafields", ["fieldable_type", "fieldable_id"], name: "index_guts_metafields_on_fieldable_type_and_fieldable_id"

  create_table "guts_navigation_items", force: :cascade do |t|
    t.string   "title"
    t.string   "custom"
    t.integer  "position",         default: 0
    t.integer  "navigatable_id"
    t.string   "navigatable_type"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "navigation_id"
  end

  add_index "guts_navigation_items", ["navigatable_type", "navigatable_id"], name: "index_nav_items_on_nav_with_type_and_id"
  add_index "guts_navigation_items", ["navigation_id"], name: "index_guts_navigation_items_on_navigation_id"

  create_table "guts_navigations", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "guts_navigations", ["slug"], name: "index_guts_navigations_on_slug", unique: true

  create_table "guts_options", force: :cascade do |t|
    t.string   "key"
    t.text     "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guts_trackers", force: :cascade do |t|
    t.integer  "object_id"
    t.string   "object_type"
    t.text     "params"
    t.text     "action"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "guts_trackers", ["object_type", "object_id"], name: "index_guts_trackers_on_object_type_and_object_id"

  create_table "guts_types", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "guts_types", ["slug"], name: "index_guts_types_on_slug", unique: true

  create_table "guts_user_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guts_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "password_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
