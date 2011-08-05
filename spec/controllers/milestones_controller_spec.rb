require 'spec_helper'

describe MilestonesController do
  context 'index' do
    it 'finds the correct milestones' do
      team = Factory(:team, :team_type => 'core')
      milestone = Factory(:milestone, :app => team.app)
      get :index, :team_name => milestone.app.core_team.name
      assigns(:team).should == team
      assigns(:milestones).should == [milestone]
      response.should be_success
    end
  end
  describe 'user signed in' do
    before do
      @user = Factory(:user)
      sign_in(@user)
    end
    context 'edit' do
      it 'sets the milestone goal correctly' do
        milestone = Factory(:milestone)
        get :edit, :id => milestone.id
        response.should be_success
      end
    end
  
    context 'create' do
      it 'wont create a milestone cause you dont have the core team cred' do
        team = Factory(:team)
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'
        post :create, :milestone => {:name => 'blah', :description => 'blah', :app_id => team.app_id}
        response.should redirect_to request.env['HTTP_REFERER']
      end

      it 'properly creates milestone with goal and app if you are a member of the core team' do
        team = Factory(:team)
        team.team_members.create(:user => @user, :admin => true, :team_role => "loser")
        post :create, :milestone => {:name => 'blah', :description => 'blah', :app_id => team.app_id}
        assigns(:milestone).app.should == team.app
        response.should redirect_to team_milestone_path(team.name, assigns(:milestone).id)
      end
    end
    
    context 'new' do
      it 'wonts to access a new milestone but you dont have the core team cred. damn.' do
        team = Factory(:team)
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'
        get :new, :team_name => team.name, :goal => 1
        response.should redirect_to request.env['HTTP_REFERER']
      end

      it 'properly creates milestone with goal and app if you are a member of the core team' do
        team = Factory(:team)
        team.team_members.create(:user => @user, :admin => true, :team_role => "loser")
        get :new, :team_name => team.name, :goal => 1
        assigns(:milestone).app.should == team.app
        assigns(:milestone).goal.should == 1
        response.should be_success
      end
    end
    
  end
end