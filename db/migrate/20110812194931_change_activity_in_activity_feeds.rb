class ChangeActivityInActivityFeeds < ActiveRecord::Migration
  def self.up
    remove_column :activty_feeds, :activity
    add_column :activty_feeds, :activity, :text
  end

  def self.down
    remove_column :activty_feeds, :activity
    add_column :activty_feeds, :activity, :string

  end
end