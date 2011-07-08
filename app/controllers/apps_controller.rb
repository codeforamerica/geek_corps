class AppsController < InheritedResources::Base
  before_filter :require_admin!, :except => [:show, :index]
  
  def show
    params[:id].to_i==0 ? @app = Team.where(:name => params[:id].downcase).first.app : @app = App.where(:id => params[:id]).first
  end
  
end
