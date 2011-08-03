class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  belongs_to :app

  validates_presence_of :user, :team, :app

  before_validation :on => :create do
    self.app ||= self.team.app
  end
end
