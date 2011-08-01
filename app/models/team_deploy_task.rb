class TeamDeployTask < ActiveRecord::Base
  belongs_to :deploy_task
  belongs_to :team
end
