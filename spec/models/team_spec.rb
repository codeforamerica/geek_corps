require 'spec_helper'

describe Team do
  
  it "should create a unique name" do
    @team = Factory(:team)
    @team.name.should == (@team.region.nick_name + "-" + @team.app.name).gsub(" ", "-").downcase
  end
  
end
