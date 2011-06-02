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

ActiveRecord::Schema.define(:version => 20110602163032) do

  create_table "batchbook_contacts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_sources", :force => true do |t|
    t.string "name"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "github_contacts", :force => true do |t|
    t.string   "gravatar_id"
    t.string   "company"
    t.string   "name"
    t.datetime "created_at"
    t.string   "location"
    t.integer  "public_repo_count"
    t.integer  "public_gist_count"
    t.string   "blog"
    t.integer  "following_count"
    t.string   "type"
    t.integer  "followers_count"
    t.string   "login"
    t.boolean  "permission"
    t.string   "email"
    t.integer  "contact_source_id"
    t.datetime "first_commit"
    t.datetime "updated_at"
  end

  add_index "github_contacts", ["contact_source_id"], :name => "index_github_contacts_on_contact_source_id"
  add_index "github_contacts", ["created_at"], :name => "index_github_contacts_on_created_at"
  add_index "github_contacts", ["followers_count"], :name => "index_github_contacts_on_followers_count"
  add_index "github_contacts", ["following_count"], :name => "index_github_contacts_on_following_count"
  add_index "github_contacts", ["login"], :name => "index_github_contacts_on_login"
  add_index "github_contacts", ["public_gist_count"], :name => "index_github_contacts_on_public_gist_count"
  add_index "github_contacts", ["public_repo_count"], :name => "index_github_contacts_on_public_repo_count"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
