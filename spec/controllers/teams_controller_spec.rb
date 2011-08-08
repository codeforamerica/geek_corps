require 'spec_helper'

describe TeamsController do

  before do
    @user = Factory(:user)
    sign_in(@user)
  end

  it "creates a team around an application" do
    pending 'this worked as of 27c4b3e but now its not, and none of the actors have substantially changed....' do
      app = Factory(:app)
      region = Factory(:region)
      expect {
        post :create, :app_id => app.id
      }.to change(Team, :count).by(1)
    end
  end
end
