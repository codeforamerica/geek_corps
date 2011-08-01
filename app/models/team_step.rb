class TeamStep < ActiveRecord::Base
  belongs_to :step
  belongs_to :team
end
