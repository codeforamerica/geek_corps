class DeployTaskResourcesController < InheritedResources::Base
  before_filter :authenticate_user!
    
  def edit
    if check_team_admin
      @deploy_task_resource = DeployTaskResource.where(:id => params[:id]).first
      render "resources/edit"
    else
      flash[:error] = "Quit trying to edit without core team cred!"
      redirect_to :back
    end      
  end
  
  def create
    if check_team_admin
      @deploy_task_resource = DeployTaskResource.new(params[:deploy_task_resource])
      @deploy_task_resource.team = @team
      if @deploy_task_resource.save
        flash[:success] = "Oh man, you got another resource! That's some more work!"
      else
        flash[:error] = "Didn't save, weirdness!"
      end    
    redirect_to "#{@deploy_task_resource.team.to_url}/guide/#{@deploy_task_resource.deploy_task.class.to_s.downcase}/#{@deploy_task_resource.deploy_task_id}" 
    else
      flash[:error] = "What? Creating a Resource without core team cred. You're nuts."      
      redirect_to :back
    end

  end
    
  def new
    if check_team_admin
      @deploy_task_resource = DeployTaskResource.new(:team_id => @team.id, :deploy_task_id => params[:deploy_task_id])
    render "resources/new"
    else
      flash[:error] = "You're killing me. No core team cred means no new resource!"
      redirect_to :back
    end
  end
  
  def update
    if check_team_admin
      @deploy_task_resource = DeployTaskResource.where(:id => params[:id]).first
      if @deploy_task_resource.update_attributes(params[:deploy_task_resource])
        flash[:success] = "It's updated, feel better?"
      else
        flash[:error] = "Didn't update!"
      end    
    else
      flash[:error] = "What? Creating a deploy_task_resource without core team cred. You're nuts."      
    end  
    redirect_to "#{@deploy_task_resource.team.to_url}/guide/#{@deploy_task_resource.deploy_task.class.to_s.downcase}/#{@deploy_task_resource.deploy_task_id}" 
  end


  def destroy
    if check_team_admin
      DeployTaskResource.where(:id => params[:id]).first.delete
      flash[:success] = "It's gone, feel better?"
    else
      flash[:error] = "Don't destroy things that don't belong to you. It's just rude."
    end
    redirect_to :back
  end
      
end