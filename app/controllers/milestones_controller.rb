class MilestonesController < InheritedResources::Base

  def index
    find_team
  end

end
