require 'spec_helper'

describe TeamsController do

  before do
    @user = Factory(:user)
    sign_in(@user)
  end

  describe '#create' do
     before do
       post :create, :team => Factory.attributes_for(:team)
       @team = Team.find(:first)
       @response = response
     end

     it "should create a team" do
       Team.all.size.should == 1
     end

   end



end
