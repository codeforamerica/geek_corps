class MilestonesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  def index
    find_team
    @milestones = Milestone.where(:app_id => @team.app.id)
  end
  
  def edit
    @milestone = Milestone.new
    @milestone.goal = params[:goal]
  end
  
  def create
    if App.where(:id => params[:milestone][:app_id]).first.admin?(current_user)
      @milestone = Milestone.new(params[:milestone])
      if @milestone.save
        flash[:success] = "Oh man, you got another milestone! That's some more work!"
        redirect_to team_milestone_path(@milestone.app.core_team.name, @milestone)
      end
    else
      flash[:error] = "You need to be a member of the core team to add a milestone!"
      redirect_to :back
    end
  end
  
  def new
    find_team
    if @team.app.admin?(current_user)
      @milestone = Milestone.new(:app_id => @team.app_id, :goal => params[:goal])
    else
      flash[:error] = "You need to be a member of the core team to add a milestone!"
      redirect_to :back      
    end
  end

end
