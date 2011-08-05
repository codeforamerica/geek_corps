class UpateDeployTasksTable < ActiveRecord::Migration
  def self.up
    add_column :deploy_tasks, :goal, :integer, :default => 1
    add_column :deploy_tasks, :est_time, :integer, :default => 0
    add_column :deploy_tasks, :position, :integer, :default => 0
    add_column :deploy_tasks, :name, :string
    add_column :deploy_tasks, :description, :text
  end

  def self.down
    remove_column :deploy_tasks, :goal
    remove_column :deploy_tasks, :est_time
    remove_column :deploy_tasks, :position
    remove_column :deploy_tasks, :name
    remove_column :deploy_tasks, :description
  end
end
