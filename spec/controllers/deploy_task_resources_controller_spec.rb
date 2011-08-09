require 'spec_helper'

describe DeployTaskResourcesController do
  describe 'user signed in' do
    before do
      @user = Factory(:user)
      sign_in(@user)
    end
    context 'edit' do
      it 'wont let you see edit unless u got the core or admin cred' do
        team = Factory(:team)
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'
        deploy_resource = Factory(:deploy_task_resource, :team => team)
        get :edit, :id => deploy_resource.id, :team_name => team.name
        response.should redirect_to request.env['HTTP_REFERER']
      end
      
      it 'properly creates deploy_resource with milestone and app if you are a member of the team' do
        team = Factory(:team)
        deploy_resource = Factory(:deploy_task_resource, :team => team)
        team.team_members.create(:user => @user, :admin => true, :team_role => "loser")
        get :edit, :id => deploy_resource.id, :team_name => deploy_resource.team.name
        response.should be_success
      end
    end
  
    context 'create' do
      it 'wont create a deploy_resource cause you dont have the core team cred' do
        team = Factory(:team)
        milestone = Factory(:milestone, :app => team.app)
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'
        post :create, :deploy_task_resource =>Factory.attributes_for(:deploy_task_resource), :team_name => team.name
        response.should redirect_to request.env['HTTP_REFERER']
      end

      it 'properly creates deploy_resource with goal and app if you are a member of the core team' do
        team = Factory(:team)
        team.team_members.create(:user => @user, :admin => true, :team_role => "loser")
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'        
        milestone = Factory(:milestone, :app => team.app)        
        post :create, :deploy_task_resource =>Factory.attributes_for(:deploy_task_resource), :team_name => team.name
        assigns(:deploy_task_resource).team.should == team
      end
    end
    
    context 'new' do
      it 'wonts to access a new deploy_resource but you dont have the core team cred. damn.' do
        team = Factory(:team)
        milestone = Factory(:milestone, :app => team.app)
        request.env['HTTP_REFERER'] = '/' + team.to_url + '/guide'
        get :new, :deploy_task_id => milestone.id, :team_name => team.name
        response.should redirect_to request.env['HTTP_REFERER']
      end

      it 'properly creates deploy_resource with goal and app if you are a member of the core team' do
        team = Factory(:team)
        team.team_members.create(:user => @user, :admin => true, :team_role => "loser")
        milestone = Factory(:milestone, :app => team.app)  
        get :new, :deploy_task_id => milestone.id, :team_name => team.name
        assigns(:deploy_task_resource).team.should == team
        assigns(:deploy_task_resource).deploy_task_id.should == milestone.id        
        response.should be_success
      end
    end
    
  end
end