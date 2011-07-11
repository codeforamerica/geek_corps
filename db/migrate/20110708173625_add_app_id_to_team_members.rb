class AddAppIdToTeamMembers < ActiveRecord::Migration
  def self.up
    add_column :team_members, :app_id, :integer
  end

  def self.down
    remove_column :team_members, :app_id
  end
end
