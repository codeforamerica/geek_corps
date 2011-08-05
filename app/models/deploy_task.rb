class DeployTask < ActiveRecord::Base
  belongs_to :app
  has_many :team_deploy_tasks
  has_many :teams, :through => :team_deploy_tasks
  has_many :deploy_task_resources
  has_many :comments, :as => :commentable

  accepts_nested_attributes_for :deploy_task_resources

end
