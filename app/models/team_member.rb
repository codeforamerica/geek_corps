class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_many :activity_feeds, :as => :feedable

  validates_presence_of :user, :team

end
