class Team < ActiveRecord::Base
  has_many :team_members
  has_many :members, :through => :team_members, :source => :user
  has_many :admins, :through => :team_members, :source => :user, :conditions => {:team_members => {:admin => true}}
  has_many :details
  before_create :create_team_name
  has_many :team_deploy_tasks
  has_many :deploy_tasks, :through => :team_deploy_tasks
  has_many :activity_feeds
  has_many :comments, :as => :commentable

  # creates a unique team name based upon region's nickname "SF" and the app name

  def create_team_name
    if self.team_type != "core"
      new_name = region.nick_name.to_s + "-" + app.name.to_s
      self.name = new_name.gsub(" ", "-").downcase
    else
      self.name = app.name.gsub(" ", "-").downcase
    end
  end

  def to_url
    "/" + self.name
  end

  def pretty_name
    self.name.gsub('-', " ").downcase.titleize
  end

  def admin?(user)
    admins.include? user
  end

end
