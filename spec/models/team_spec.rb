require 'spec_helper'

describe Team do
  context 'associates' do
    before do
      @team = Factory.build(:team)
    end
    it 'many team members' do
      @team.respond_to?(:team_members).should be_true
    end
    it 'many members' do
      @team.respond_to?(:members).should be_true
    end
    it 'many details' do
      @team.respond_to?(:details).should be_true
    end
    it 'belongs to region' do
      @team.respond_to?(:region).should be_true
    end
    it 'belongs to app' do
      @team.respond_to?(:app).should be_true
    end
  end
  context 'create_team_name' do
    before do
      @team = Factory.build(:team)
    end
    it "should create a unique name for an implementation team" do
      @team.team_type = 'substantial'
      @team.save(:validate => false)
      @team.name.should == (@team.region.nick_name + "-" + @team.app.name).gsub(" ", "-").downcase
    end
    it "should create a name that matches the application if its the core team" do
      @team.team_type = "core"
      @team.save(:validate => false)
      @team.name.should == @team.app.name
    end
  end
end
