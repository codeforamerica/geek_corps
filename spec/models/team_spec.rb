require 'spec_helper'

describe Team do
  
  it "should create a unique name for an implementation team" do
    @team = Factory(:team)
    @team.name.should == (@team.region.nick_name + "-" + @team.app.name).gsub(" ", "-").downcase
  end
  
  it "should create a name that matches the application if its the core team" do
    @team = Factory(:team, :team_type => "core")
    @team.name.should == @team.app.name
  end
  
end
