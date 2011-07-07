class Team < ActiveRecord::Base
  has_many :team_members
  has_many :members, :through => :team_members, :source => :team
  belongs_to :region
  has_many :details
  belongs_to :app
  before_create :create_team_name

  validates_uniqueness_of :region_id, :scope => :app_id  
  
  # creates a unique team name based upon region's nickname "SF" and the app name

  def create_team_name
    new_name = region.nick_name.to_s + "-" + app.name.to_s
    self.name = new_name.gsub(" ", "-").downcase
  end

  
end
