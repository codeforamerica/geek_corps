require 'spec_helper'

describe TeamsController do

  before do
    @user = Factory(:user)
    sign_in(@user)
  end
  
  it "creates a team around an application" do
    app = Factory(:app)
    region = Factory(:region)
    expect {
      post :create, :app_id => app.id
    }.to change(Team, :count).by(1)
    Team.last.members.count.should == 1
  end
  
  

end
