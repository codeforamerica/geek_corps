class TeamsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index, :people]

  def create
    app = App.where(:id => params[:app_id]).first
    @team = Team.new(:region => current_user.region, :app => app, :team_type => "application")
    @team.team_members.build(:user => current_user, :team_role => "organizer", :admin => true, :app => app)
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
