class MembersController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index]
  layout "apps"
  
  def create
    team = Team.where(:id => params[:team_id]).first
    @members = TeamMember.new(:user => current_user, :team_role => params[:team_role], :team => team)
    create! do |format|
      format.html { redirect_to team }
    end
  end
  
end
