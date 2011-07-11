class UpdatePerson < ActiveRecord::Migration
  def self.up
    add_column :people, :twitter, :string
    add_column :people, :url, :string
    add_column :people, :user_id, :integer
    add_column :people, :name,    :string
    add_column :people, :imported_from_provider, :string
    add_column :people, :imported_from_id, :string
    add_column :people, :photo_file_name,  :string
    add_column :people, :photo_content_type,:string
    add_column :people, :photo_file_size,  :integer
    add_column :people, :photo_updated_at, :datetime
    add_column :people, :reviewed, :boolean, :default => false
    add_column :people, :imported_from_screen_name, :string
  end

  def self.down
  end
end
