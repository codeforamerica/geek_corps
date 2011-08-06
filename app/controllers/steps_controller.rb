class StepsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  def edit
    if check_core_team
      @step = Step.where(:id => params[:id]).first
    else
     flash[:error] = "Quit trying to edit without core team cred!"
     redirect_to :back
    end
  end

  def create
    if check_core_team
      @step = Step.new(params[:step])
      @step.app = @team.app
      if @step.save
        flash[:success] = "Oh man, you got another step! That's some more work!"
        redirect_to team_step_path(@step.app.core_team.name, @step)
      end
    else
      flash[:error] = "You need to be a member of the core team to add a step!"
      redirect_to :back
    end
  end

  def new
    if check_core_team 
      milestone = Milestone.where(:id => params[:milestone]).first
      @step = Step.new(:app_id => @team.app_id, :parent_id => milestone.id )
    else
      flash[:error] = "You need to be a member of the core team to add a step!"
      redirect_to :back
    end
  end
  
  def show
    find_team
    @step = Step.where(:id => params[:id]).first
  end
  
  def update
    if check_core_team
      @step = Step.where(:id => params[:id]).first
      if @step.update_attributes(params[:step])
        flash[:success] = "It's updated, feel better?"
      else
        flash[:error] = "Didn't update!"
      end    
      redirect_to team_step_path(@step.app.core_team.name, @step)
    else
      flash[:error] = "What? Creating a step without core team cred. You're nuts."      
      redirect_to :back
    end
    
  end

end
