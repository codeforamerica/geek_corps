class Step < ActiveRecord::Base
  belongs_to :app
  belongs_to :parent, :class_name => 'Step'
  has_many :children, :class_name => 'Step', :foreign_key => :parent_id
  has_many :team_steps
  has_many :teams, :through => :team_steps
  has_many :step_resources
  has_many :comments, :as => :commentable
end
