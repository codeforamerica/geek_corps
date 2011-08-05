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

ActiveRecord::Schema.define(:version => 20110805185055) do

  create_table "activity_feeds", :force => true do |t|
    t.integer  "team_id"
    t.string   "feedable_type"
    t.integer  "feedable_id"
    t.string   "activity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apps", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "access_token_secret"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "batchbook_contacts", :force => true do |t|
    t.integer  "batchbook_id"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "primary"
    t.string   "label"
    t.integer  "location_id"
    t.string   "email"
    t.string   "website"
    t.string   "phone"
    t.string   "cell"
    t.string   "state"
    t.string   "city"
    t.string   "postal_code"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "flag"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentable_type"
    t.integer  "commentable_id"
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

  create_table "deploy_task_resources", :force => true do |t|
    t.integer  "deploy_task_id"
    t.integer  "team_id"
    t.string   "type"
    t.text     "content"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deploy_tasks", :force => true do |t|
    t.integer  "app_id"
    t.string   "type"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "goal",        :default => 1
    t.integer  "est_time",    :default => 0
    t.integer  "position",    :default => 0
    t.string   "name"
    t.text     "description"
  end

  create_table "details", :force => true do |t|
    t.integer  "app_id"
    t.integer  "team_id"
    t.string   "name"
    t.string   "setting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.integer  "polyglot_id"
    t.string   "polyglot_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "bio"
    t.string   "location"
    t.float    "lat"
    t.float    "long"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter"
    t.string   "url"
    t.integer  "user_id"
    t.string   "name"
    t.string   "imported_from_provider"
    t.string   "imported_from_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "reviewed",                  :default => false
    t.string   "imported_from_screen_name"
  end

  create_table "regions", :force => true do |t|
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nick_name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.datetime "photo_updated_at"
    t.integer  "photo_file_size"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "rolable_id"
    t.string   "rolable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.integer  "skillable_id"
    t.string   "skillable_type"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "team_deploy_tasks", :force => true do |t|
    t.integer  "team_id"
    t.integer  "deploy_task_id"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_members", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.string   "team_role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",      :default => false
    t.integer  "app_id"
  end

  create_table "teams", :force => true do |t|
    t.integer  "app_id"
    t.integer  "region_id"
    t.string   "team_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "repo_url"
  end

  create_table "users", :force => true do |t|
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.boolean  "admin",               :default => false
    t.integer  "region_id"
  end

end
