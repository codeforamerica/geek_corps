class DeployTask < ActiveRecord::Base
  belongs_to :app
  has_many :team_deploy_tasks
  has_many :teams, :through => :team_deploy_tasks
  has_many :deploy_task_resources
  has_one  :heading
  has_one  :description
  has_many :comments, :as => :commentable

  accepts_nested_attributes_for :deploy_task_resources, :heading, :description
  def title
    heading.content
  end

  def content
    description.content
  end

end
