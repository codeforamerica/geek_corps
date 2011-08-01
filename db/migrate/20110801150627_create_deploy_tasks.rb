class CreateDeployTasks < ActiveRecord::Migration
  def self.up
    create_table :deploy_tasks do |t|
      t.integer :app_id
      t.string  :type
      t.integer :parent_id
      t.timestamps
    end
  end

  def self.down
    drop_table :deploy_tasks
  end
end
