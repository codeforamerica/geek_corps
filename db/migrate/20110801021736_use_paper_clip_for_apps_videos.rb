class UsePaperClipForAppsVideos < ActiveRecord::Migration
  def self.up
    remove_column :apps, :video_url
    add_column    :apps, :video_file_name,    :string
    add_column    :apps, :video_content_type, :string
    add_column    :apps, :video_file_size,    :integer
    add_column    :apps, :video_updated_at,   :datetime
  end

  def self.down
    add_column    :apps,  :video_url, :string
    remove_column :apps,  :video_file_name
    remove_column :apps,  :video_content_type
    remove_column :apps,  :video_file_size
    remove_column :apps,  :video_updated_at
  end
end
