class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.rememberable
      t.trackable
      t.timestamps
      t.string :email
      t.boolean :admin, :default => false      
    end

  end

  def self.down
    drop_table :users
  end
end