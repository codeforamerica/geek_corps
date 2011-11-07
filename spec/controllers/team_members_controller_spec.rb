require 'spec_helper'

describe TeamMembersController do

  before do
    @team = Factory(:team)
    @user = Factory(:user)
    @admin = Factory(:team_member, :user => @user, :team => @team)
    sign_in @user
  end

  describe 'update' do
    pending it 'should promote if user was not admin on success' do
      person = Factory(:person)
      user = Factory(:user, :person => person)
      request.env['HTTP_REFERER'] = '/art-application/people'
      team_member = Factory(:team_member, :team => @team, :user => user)
      put :update, :id => team_member.id
      flash[:success].should == "#{team_member.user.person.name} has been promoted to admin for #{@team.name}"
    end
    pending it 'should demote if user was admin on success' do
      person = Factory(:person)
      user = Factory(:user, :person => person)
      request.env['HTTP_REFERER'] = '/art-application/people'
      team_member = Factory(:team_member, :team => @team, :user => user)
      put :update, :id => team_member.id
      flash[:success].should == "#{team_member.user.person.name} has been demoted from admin of #{@team.name}"
    end
     pending it 'should render flash[:error] if current user is not admin' do
      @admin.admin = false
      @admin.save!
      person = Factory(:person)
      user = Factory(:user, :person => person)
      request.env['HTTP_REFERER'] = '/art-application/people'
      team_member = Factory(:team_member, :team => @team, :user => user)
      put :update, :id => team_member.id
      flash[:error].should == 'You gotta have power to promote folks around here'
    end
  end

  pending 'toggle_admin_status'
  pending 'promote'
  pending 'demote'

end
