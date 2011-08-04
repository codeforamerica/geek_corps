class ActivityFeed < ActiveRecord::Base
  belongs_to :team
  belongs_to :feedable, :polymorphic => true
  
  
  validates_presence_of :team, :on => :create, :message => "can't be blank"
  
  
  
end
