require 'spec_helper'

describe StepsController do
  describe 'user signed in' do
    before do
      @user = Factory(:user)
      sign_in(@user)
    end
    context 'edit' do
      it 'sets the steps goal correctly' do
        step = Factory(:step)
        get :edit, :id => step.id
        response.should be_success
      end
    end
  
    context 'create' do
      it 'wont create a step cause you dont have the core team cred' do
        team = Factory(:team)
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'
        post :create, :step => {:name => 'blah', :description => 'blah', :app_id => team.app_id}
        response.should redirect_to request.env['HTTP_REFERER']
      end

      it 'properly creates step with milestone and app if you are a member of the core team' do
        team = Factory(:team)
        team.team_members.create(:user => @user, :admin => true, :team_role => "loser")
        post :create, :step => {:name => 'blah', :description => 'blah', :app_id => team.app_id}
        assigns(:step).app.should == team.app
        response.should redirect_to team_step_path(team.name, assigns(:step).id)
      end
    end
    
    context 'new' do
      it 'wonts to access a new step but you dont have the core team cred. damn.' do
        team = Factory(:team)
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'
        get :new, :team_name => team.name, :goal => 1
        response.should redirect_to request.env['HTTP_REFERER']
      end

      it 'properly creates step with milestone and app if you are a member of the core team' do
        team = Factory(:team)
        team.team_members.create(:user => @user, :admin => true, :team_role => "loser")
        get :new, :team_name => team.name, :milestone => 1
        assigns(:step).app.should == team.app
        assigns(:step).milestone.should == 1
        response.should be_success
      end
    end 
  end
end