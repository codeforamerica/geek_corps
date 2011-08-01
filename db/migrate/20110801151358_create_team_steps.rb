class CreateTeamSteps < ActiveRecord::Migration
  def self.up
    create_table :team_steps do |t|
      t.integer   :team_id
      t.integer   :step_id
      t.boolean   :completed
      t.timestamps
    end
  end

  def self.down
    drop_table :team_steps
  end
end
