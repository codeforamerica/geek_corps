class AppsController < InheritedResources::Base
  before_filter :require_admin!, :only => [:create, :new]

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

  def update
    @app = App.where(:id => params[:id]).first
    unless @app.admin? current_user
      @app = nil
      redirect_to :root,
        :alert => 'You must be logged in to do that'
    else
      if @app.update_attributes(params[:app])
        flash[:notice] = 'App successfully updated'
        redirect_to @app
      else
        flash[:alert] = 'App failed to update. Please try again.'
        render :admin
      end
    end
  end

  def people
    @app = App.where(:id => params[:id]).first
    @people = @app.users.map(&:person)
  end

  def admin
    @app = App.where(:id => params[:id]).first
    unless @app.admin? current_user
      @app = nil
      redirect_to :root,
        :alert => 'You can only access the Apps Admin area if you are an admin on the core team'
    end
  end
end
