class StepsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  def edit
    @step = Step.new
    @step.milestone = params[:milestone]
  end

  def create
    if App.where(:id => params[:step][:app_id]).first.admin?(current_user)
      @step = Step.new(params[:step])
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
    find_team
    if @team.app.admin?(current_user)
      @step = Step.new(:app_id => @team.app_id, :milestone => params[:milestone])
    else
      flash[:error] = "You need to be a member of the core team to add a step!"
      redirect_to :back
    end
  end

end
