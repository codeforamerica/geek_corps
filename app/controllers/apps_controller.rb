class AppsController < InheritedResources::Base
  before_filter :require_admin!, :except => :index

  def index
    @search = App.search(params[:search])
    @apps = @search.paginate
  end
end
