class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.integer :app_id
      t.integer :region_id
      t.string :team_type
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
