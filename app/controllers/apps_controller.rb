class AppsController < InheritedResources::Base
  before_filter :require_admin!, :except => [:show, :index, :people]

  def index
    @search = App.search(params[:search])
    @apps = @search.paginate
  end
  def show
    if params[:id].to_i==0
      @app = Team.where(:name => params[:id].downcase).first.app
    else
      @app = App.where(:id => params[:id]).first
    end
  end

  def people
    @app = App.where(:id => params[:id]).first
    users = User.joins(:team_members, :teams).where(:team_members => {:app_id => params[:id]}).where(:team_members => {:teams => {:team_type => 'core'}}).includes(:person).all
    @people = users.map(&:person)
  end

end
