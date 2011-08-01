class CreateTeamDeployTasks < ActiveRecord::Migration
  def self.up
    create_table :team_deploy_tasks do |t|
      t.integer   :team_id
      t.integer   :deploy_task_id
      t.boolean   :completed
      t.timestamps
    end
  end

  def self.down
    drop_table :team_deploy_tasks
  end
end
