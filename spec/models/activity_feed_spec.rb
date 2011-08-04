require 'spec_helper'

describe ActivityFeed do
  before do
    @team = Factory(:team)
    @activity_feed = Factory(:activity_feed, :team => @team)
  end
  
  context "validations" do    
    it "require team" do
      feed = ActivityFeed.new(Factory.attributes_for(:activity_feed, :team => nil))
      feed.save.should be_false
    end
    
    it "require feedable" do
      feed = ActivityFeed.new(Factory.attributes_for(:activity_feed, :feedable => nil))
      feed.save.should be_false
    end
    
  end
  
  context "crud functions" do    

    it 'should respond to teams' do
      @activity_feed.respond_to?(:team).should be_true
    end
    
    it 'should respond to feedable' do
      @activity_feed.respond_to?(:feedable).should be_true
    end

  end

pending "feedable"


pending "team started adds to activity feed"
pending "team member joins adds to activity feed"
pending "team member promoted to admin adds to activity feed"
pending "milestone completed adds to feed"
pending ""

end
