class AddPhotosToRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :photo_file_name, :string
    add_column :regions, :photo_content_type, :string
    add_column :regions, :photo_updated_at, :datetime
    add_column :regions, :photo_file_size, :integer
  end

  def self.down
    remove_column :regions, :photo_file_name
    remove_column :regions, :photo_content_type
    remove_column :regions, :photo_updated_at
    remove_column :regions, :photo_file_size
  end
end
