class App < ActiveRecord::Base
  has_many :teams
  has_many :details
  
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  def core_team_members
    self.teams.where(:team_type => "core").first.team_members
  end
end
