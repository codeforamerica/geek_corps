class ActivityFeed < ActiveRecord::Base
  belongs_to :team
  belongs_to :feedable, :polymorphic => true
  
  validates_presence_of :team_id
  validates_presence_of :feedable
  
end
