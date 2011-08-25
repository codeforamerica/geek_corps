class ChangeActivityInActivityFeeds < ActiveRecord::Migration
  def self.up
    remove_column :activity_feeds, :activity
    add_column :activity_feeds, :activity, :text
  end

  def self.down
    remove_column :activity_feeds, :activity
    add_column :activity_feeds, :activity, :string

  end
end
