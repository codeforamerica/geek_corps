class TeamsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index]
  
  def create
    app = App.where(:id => params[:team][:app_id]).first
    @team = Team.new(:region => current_user.region, :app => app, :team_type => "application")
    @team.team_members.build(:user => current_user, :team_role => "organizer", :admin => true)
    create!
  end
  
end
