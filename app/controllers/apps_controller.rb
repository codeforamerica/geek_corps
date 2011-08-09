class AppsController < InheritedResources::Base
  before_filter :require_admin!, :except => :index

  def index
    @apps = App.all
  end
end
