class TeamsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index, :people]
  before_filter :require_admin!, :only => [:new,:destroy,:edit,:create]

  def show
    find_team
    session[:team]=@team.hypen_name
    puts session[:join_team_id]
    puts @team.id
    if session[:join_team_id]==@team.id.to_s
      @team.members << current_user
      session[:join_team_id]=nil
    end
  end

  def people
    find_team
    users = User.joins(:team_members).where(:team_members => {:team_id => @team.id})
    @people = users.map(&:person)
  end


end
