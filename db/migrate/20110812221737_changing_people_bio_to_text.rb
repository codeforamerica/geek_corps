class ChangingPeopleBioToText < ActiveRecord::Migration
  def self.up
    remove_column :people, :bio
    add_column :people, :bio, :text
  end

  def self.down
    remove_column :people, :bio
    add_column :people, :bio, :string
  end
end
