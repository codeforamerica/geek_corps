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
      it 'wont let you see edit unless u got the core or admin cred' do
        team = Factory(:team)
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'
        milestone = Factory(:milestone, :app => team.app)
        get :edit, :id => milestone.id, :team_name => milestone.app.core_team.name
        response.should redirect_to request.env['HTTP_REFERER']
      end

      it 'properly creates milestone with goal and app if you are a member of the core team' do
        team = Factory(:team)
        milestone = Factory(:milestone, :app => team.app)
        team.team_members.create(:user => @user, :admin => true, :team_role => "loser")
        get :edit, :id => milestone.id, :team_name => milestone.app.core_team.name
        response.should be_success
      end
    end

    context 'create' do
      it 'wont create a milestone cause you dont have the core team cred' do
        team = Factory(:team)
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'
        post :create, :milestone => {:name => 'blah', :description => 'blah', :app_id => team.app_id}, :team_name =>team.name
        response.should redirect_to request.env['HTTP_REFERER']
      end

      it 'properly creates milestone with goal and app if you are a member of the core team' do
        team = Factory(:team)
        team.team_members.create(:user => @user, :admin => true, :team_role => "loser")
        post :create, :milestone => {:name => 'blah', :description => 'blah', :app_id => team.app_id}, :team_name => team.name
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

    context 'destroy' do
      it 'wont delete if user is not an admin of the core team' do
        request.env['HTTP_REFERER'] = '/welcome'
        team = Factory(:team)
        milestone = Factory(:milestone, :app => team.app)
        team.team_members.create(:user => @user, :admin => false, :team_role => 'justin')
        delete :destroy, :team_name => team.name, :id => milestone.id
        response.should redirect_to '/welcome'
      end
      it 'will delete if user is an admin of the core team and the milestone has no steps' do
        team = Factory(:team)
        milestone = Factory(:milestone, :steps => [], :app => team.app)
        team.team_members.create(:user => @user, :admin => true, :team_role => 'organizer')
        delete :destroy, :team_name => team.name, :id => milestone.id
        flash[:success].should_not be_nil
      end
      it 'wont delete if milestone contains steps' do
        request.env['HTTP_REFERER'] = '/welcome'
        team = Factory(:team)
        milestone = Factory(:milestone, :app => team.app)
        team.team_members.create(:user => @user, :admin => true, :team_role => 'organizer')
        step = Factory(:step, :milestone => milestone)
        delete :destroy, :team_name => team.name, :id => milestone.id
        response.should redirect_to '/welcome'
      end
    end
  end
end
