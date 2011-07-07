class RegionsController < InheritedResources::Base
  before_filter :require_admin!
end
