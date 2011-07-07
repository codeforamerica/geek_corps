class AddAdminToTeamMembers < ActiveRecord::Migration
  def self.up
    add_column :team_members, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :team_members, :admin
  end
end
