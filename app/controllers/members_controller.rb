class MembersController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index]
  layout "apps"
  
  def create
    team = Team.where(:id => params[:team_id]).first
    @member = TeamMember.new(:user => current_user, :team_role => "supporter", :team => team)
    create! do |format|
      format.html { redirect_to team.to_url }
    end
  end
  
end
