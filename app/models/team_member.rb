class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  belongs_to :app
  has_many :activity_feeds, :as => :feedable

  validates_presence_of :user, :team, :app

  before_validation :on => :create do
    self.app ||= self.team.app
  end
end
