class AddRegionAreaToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :region, :string
  end

  def self.down
    remove_column :teams, :region
  end
end
