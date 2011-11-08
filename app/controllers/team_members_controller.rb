class TeamMembersController < InheritedResources::Base
  before_filter :authenticate_user!

  def update
    @team_member = TeamMember.find params[:id]
    if current_user.is_admin_for.include?(@team_member) or current_user.admin?
      @team_member.admin = !(@team_member.admin)
      @team_member.save
      flash[:success] = @team_member.admin? ? 'This person now has great powers' : 'This person is now mortal'
      redirect_to :back
    else
      flash[:error] = 'You gotta have the proper powers to promote folks around here'
      redirect_to :back
    end
  end

  
end
