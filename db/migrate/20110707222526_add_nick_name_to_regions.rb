class AddNickNameToRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :nick_name, :string
  end

  def self.down
    remove_column :regions, :nick_name
  end
end