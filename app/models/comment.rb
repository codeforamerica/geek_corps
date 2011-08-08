class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  belongs_to :team
  has_one :activity_feed, :as => :feedable
  after_create :add_comment_to_activity_feed

  validates_presence_of :user, :on => :create, :message => "can't be blank"
  validates_presence_of :team, :on => :create, :message => "can't be blank"
  validates_presence_of :text, :on => :create, :message => "can't be blank"
  validates_presence_of :commentable, :on => :create, :message => "can't be blank"

  def add_comment_to_activity_feed
    activity = self.text[0..100]
    ActivityFeed.create(:team => self.team, :activity => figure_out_comment_text, :feedable => self )
  end

  def figure_out_comment_text
    case self.commentable_type
    when "Step"
    when "Milestone"
    when "Team"
      self.text
    when "Resource"
    else
    end
  end

end
