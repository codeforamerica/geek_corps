class App < ActiveRecord::Base
  has_many :teams
  has_many :details
  has_many :team_members
  has_many :members, :through => :team_members, :source => :user, :uniq => true
  
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  def core_team_members
    self.teams.where(:team_type => "core").first.team_members
  end
  
  def regional_teams
    self.teams.where(:team_type => "application")
  end
  
  def all_members
    total_members = []
    self.teams.each do |team|
      total_members << team.members
    end
    total_members.uniq!
  end
  
end
