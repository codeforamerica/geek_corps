class AppsController < InheritedResources::Base
      before_filter :require_admin!, :except => [:show, :index]
  
end
