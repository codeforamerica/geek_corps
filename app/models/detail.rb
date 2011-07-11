class Detail < ActiveRecord::Base
  belongs_to :app
  belongs_to :team
  
  validates_uniqueness_of :name, :on => :create, :scope => [:app_id, :team_id]
end
