class RemoveFieldsFromTeams < ActiveRecord::Migration
  def self.up
    remove_column :teams, :app_id
    remove_column :teams, :region_id
    remove_column :teams, :repo_url
  end

  def self.down
    add_column :teams, :repo_url, :string
    add_column :teams, :region_id, :integer
    add_column :teams, :app_id, :integer
  end
end
