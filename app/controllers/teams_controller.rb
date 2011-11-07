class TeamsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index, :people]

  def create
    @team = Team.new
    @team.team_members.build(:user => current_user, :team_role => "organizer")
    create!
  end

  def show
    find_team
  end

  def people
    find_team
    users = User.joins(:team_members).where(:team_members => {:team_id => @team.id})
    @people = users.map(&:person)
  end


end
