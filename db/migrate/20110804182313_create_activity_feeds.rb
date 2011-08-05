class CreateActivityFeeds < ActiveRecord::Migration
  def self.up
    create_table :activity_feeds do |t|
      t.integer :team_id
      t.string :feedable_type
      t.integer :feedable_id
      t.string :activity

      t.timestamps
    end
  end

  def self.down
    drop_table :activity_feeds
  end
end
