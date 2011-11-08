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
       @team.region.should == "(37.75459549838729, -122.60032236194616)(37.78933228160323, -122.2899585924149)(37.59590195263007, -122.2624927721024)(37.576313499982945, -122.56736337757116)"
       Team.all.size.should == 1
     end

   end



end
