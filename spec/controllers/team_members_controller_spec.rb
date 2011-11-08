require 'spec_helper'

describe TeamMembersController do

  describe 'admin updates' do
    before do
      @team = Factory(:team)
      @user = Factory(:user, :admin => true)
      @admin = Factory(:team_member, :user => @user, :team => @team)
      sign_in @user
    end
    
     it 'should promote if user was not admin on success' do
      person = Factory(:person)
      user = Factory(:user, :person => person)
      request.env['HTTP_REFERER'] = '/art-application/people'
      team_member = Factory(:team_member, :team => @team, :user => user)
      put :update, :id => team_member.id
      flash[:success].should == 'This person now has great powers'
    end
     it 'should demote if user was admin on success' do
      person = Factory(:person)
      user = Factory(:user, :person => person)
      request.env['HTTP_REFERER'] = '/art-application/people'
      team_member = Factory(:team_member, :team => @team, :user => user, :admin => true)
      put :update, :id => team_member.id
      flash[:success].should == 'This person is now mortal'
    end
  end
  
  describe 'team admin updates' do
    before do
      @team = Factory(:team)
      @user = Factory(:user)
      @admin = Factory(:team_member, :user => @user, :team => @team, :admin => true )
      sign_in @user
    end
    
    it 'should render flash[:error] if current user is not admin' do
    person = Factory(:person)
    user = Factory(:user, :person => person)
    request.env['HTTP_REFERER'] = '/art-application/people'
    team_member = Factory(:team_member, :team => @team, :user => user)
    put :update, :id => team_member.id
    flash[:error].should == 'You gotta have the proper powers to promote folks around here'
    end
  end


  describe 'regular user updates' do
    before do
      @team = Factory(:team)
      @user = Factory(:user)
      @admin = Factory(:team_member, :user => @user, :team => @team)
      sign_in @user
    end
    
    it 'should render flash[:error] if current user is not admin' do
    person = Factory(:person)
    user = Factory(:user, :person => person)
    request.env['HTTP_REFERER'] = '/art-application/people'
    team_member = Factory(:team_member, :team => @team, :user => user)
    put :update, :id => team_member.id
    flash[:error].should == 'You gotta have the proper powers to promote folks around here'
    end
  end
  


end
