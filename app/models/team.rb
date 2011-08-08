class Team < ActiveRecord::Base
  has_many :team_members
  has_many :members, :through => :team_members, :source => :user
  has_many :admins, :through => :team_members, :source => :user, :conditions => {:team_members => {:admin => true}}
  belongs_to :region
  has_many :details
  belongs_to :app
  before_create :create_team_name
  has_many :team_deploy_tasks
  has_many :deploy_tasks, :through => :team_deploy_tasks
  has_many :activity_feeds

  validates_presence_of :region, :unless => Proc.new { |team| team.team_type == 'core' }
  validates_uniqueness_of :region_id, :scope => :app_id, :unless => Proc.new { |team| team.team_type == 'core' }

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

  def admin?(user)
    admins.include? user
  end

end
