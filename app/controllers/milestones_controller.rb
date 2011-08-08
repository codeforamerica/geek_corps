class MilestonesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    find_team
    @milestones = Milestone.where(:app_id => @team.app.id)
  end
  
  def edit
    if check_core_team
      @milestone = Milestone.where(:id => params[:id]).first
    else
      flash[:error] = "Quit trying to edit without core team cred!"
       redirect_to :back
     end      
  end
  
  def create
    if check_core_team
      @milestone = Milestone.new(params[:milestone])
      @milestone.app = @team.app
      if @milestone.save
        flash[:success] = "Oh man, you got another milestone! That's some more work!"
      else
        flash[:error] = "Didn't save, weirdness!"
      end    
      redirect_to team_milestone_path(@milestone.app.core_team.name, @milestone)
    else
      flash[:error] = "What? Creating a milestone without core team cred. You're nuts."      
      redirect_to :back
    end
  end
  
  def show
    find_team
    @milestone = Milestone.where(:id => params[:id]).first
  end
  
  def new
    if check_core_team
      @milestone = Milestone.new(:app_id => @team.app_id, :goal => params[:goal])
    else
      flash[:error] = "You're killing me. No core team cred means no new milestones!"
      redirect_to :back
    end
  end
  
  def update
    if check_core_team
      @milestone = Milestone.where(:id => params[:id]).first
      if @milestone.update_attributes(params[:milestone])
        flash[:success] = "It's updated, feel better?"
      else
        flash[:error] = "Didn't update!"
      end    
      redirect_to team_milestone_path(@milestone.app.core_team.name, @milestone)
    else
      flash[:error] = "What? Creating a milestone without core team cred. You're nuts."      
      redirect_to :back
    end
    
  end
  


end
