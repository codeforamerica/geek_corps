class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :bio
      t.string :location
      t.float :lat
      t.float :long
      t.string :picture

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
