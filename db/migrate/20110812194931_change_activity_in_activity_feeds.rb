class ChangeActivityInActivityFeeds < ActiveRecord::Migration
  def self.up
    change_table :activity_feeds do |t|
         t.change :activity, :text
    end
  end

  def self.down
    change_table :activity_feeds do |t|
      t.change :activity, :string
    end
  end
end
