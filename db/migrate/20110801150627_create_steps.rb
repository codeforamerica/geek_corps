class CreateSteps < ActiveRecord::Migration
  def self.up
    create_table :steps do |t|
      t.integer :app_id
      t.string  :step_type
      t.integer :parent_id
      t.timestamps
    end
  end

  def self.down
    drop_table :steps
  end
end
