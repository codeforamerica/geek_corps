require 'spec_helper'

describe Comment do
  before do
    @comment = Factory(:comment)
  end
  
  context "validations" do    
    it "require team" do
      comment = Comment.new(Factory.attributes_for(:comment, :team => nil))
      comment.save.should be_false
    end
    
    it "require commentable" do
      comment = Comment.new(Factory.attributes_for(:comment, :commentable => nil))
      comment.save.should be_false
    end

    it "require user" do
      comment = Comment.new(Factory.attributes_for(:comment, :user => nil))
      comment.save.should be_false
    end

    
  end
  
  context "crud functions" do    

    it 'should respond to teams' do
      @comment.respond_to?(:team).should be_true
    end
    
    it 'should respond to commentable' do
      @comment.respond_to?(:commentable).should be_true
    end
    
    it 'should respond to user' do
      @comment.respond_to?(:user).should be_true
    end

  end
  
  context "comment text for activity feeds" do    
    it 'should figure out comment text based upon commentable type' do
      @comment.commentable_type = "Team"
      @comment.save
      @comment.figure_out_comment_text.should == @comment.text
    end
    
    it 'should post to activity feed as a team' do
      # @comment.commentable is "Team"
      @comment.activity_feed.activity.should == @comment.text
    end
    
    pending 'step comments'
    pending 'milestones'
    pending 'resource'
    
  end
      
      
end