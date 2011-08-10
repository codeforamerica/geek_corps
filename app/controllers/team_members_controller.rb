class TeamMembersController < InheritedResources::Base
  before_filter :authenticate_user!

  def update
    @team_member = TeamMember.find params[:id]
    if @team_member.team.admin? current_user
      toggle_admin_status @team_member
      redirect_to :back
    else
      flash[:error] = 'You gotta have power to promote folks around here'
      redirect_to :back
    end
  end

  private

  def toggle_admin_status(team_member)
    if team_member.admin == false
      promote team_member
    else team_member.admin == true
      demote team_member
    end
  end

  def promote(team_member)
    team_member.admin = true
    if team_member.save
      flash[:success] = "#{team_member.user.person.name} has been promoted to admin for #{team_member.team.name}"
    else
      flash[:error] = "Oh noes! There was an error promoting this person"
    end
  end

  def demote(team_member)
    team_member.admin = false
    if team_member.save
      flash[:success] = "#{team_member.user.person.name} has been demoted from admin of #{team_member.team.name}"
    else
      flash[:error] = "Oh noes! There was an error promoting this person"
    end
  end
end
