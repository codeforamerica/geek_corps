class AddRepoUrlToTeamsTable < ActiveRecord::Migration
  def self.up
    add_column  :teams, :repo_url,  :string
  end

  def self.down
    remove_column :teams, :repo_url
  end
end
