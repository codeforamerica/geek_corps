class CreateDetails < ActiveRecord::Migration
  def self.up
    create_table :details do |t|
      t.integer :app_id
      t.integer :team_id
      t.string :name
      t.string :setting

      t.timestamps
    end
  end

  def self.down
    drop_table :details
  end
end
