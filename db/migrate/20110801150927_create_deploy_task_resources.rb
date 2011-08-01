class CreateDeployTaskResources < ActiveRecord::Migration
  def self.up
    create_table :deploy_task_resources do |t|
      t.integer :deploy_task_id
      t.integer :team_id
      t.string  :resource_type
      t.text    :content
      t.string  :link
      t.timestamps
    end
  end

  def self.down
    drop_table :deploy_task_resources
  end
end
