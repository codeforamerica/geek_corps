class CreateStepResources < ActiveRecord::Migration
  def self.up
    create_table :step_resources do |t|
      t.integer :step_id
      t.integer :team_id
      t.string  :resource_type
      t.text    :content
      t.string  :link
      t.timestamps
    end
  end

  def self.down
    drop_table :step_resources
  end
end
