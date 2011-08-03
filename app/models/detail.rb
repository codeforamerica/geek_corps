class Detail < ActiveRecord::Base
  belongs_to :app
  belongs_to :team

  validates_uniqueness_of :name, :on => :create, :scope => [:app_id, :team_id]
  validates_presence_of :name, :setting, :app, :team

  before_validation :on => :create do
    self.app ||= self.team.app
    self.team ||= self.app.core_team
  end
end
