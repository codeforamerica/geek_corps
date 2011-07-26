class CreateSkills < ActiveRecord::Migration
  def self.up
    create_table :skills do |t|
      t.string :name
      t.references :skillable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :skills
  end
end
