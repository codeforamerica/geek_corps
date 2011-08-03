class ChangeResourceTypeToTypeColumnInDeployTaskResourcesTable < ActiveRecord::Migration
  def self.up
    rename_column :deploy_task_resources, :resource_type, :type
  end

  def self.down
    rename_column :deploy_task_resources, :type, :resource_type
  end
end
