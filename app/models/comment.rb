class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  belongs_to :team
  has_many :activity_feeds, :as => :feedable
  
  validates_presence_of :user, :on => :create, :message => "can't be blank"
  validates_presence_of :team, :on => :create, :message => "can't be blank"
  validates_presence_of :text, :on => :create, :message => "can't be blank"
end
