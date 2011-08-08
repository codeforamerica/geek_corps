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
    it 'should figure out comment text based upon team type' do
      @comment.commentable_type = "Team"
      @comment.save
      @comment.figure_out_comment_text.should == @comment.text
    end

    it 'should post to activity feed as a team' do
      @comment.activity_feed.activity.should == @comment.text
    end
    
    it 'should figure out comment text based upon milestone type' do
      milestone = Factory(:milestone)
      team = Factory(:team)
      comment = Factory(:comment, :commentable => milestone, :team => team )
      comment.commentable.should == milestone
      comment.team.should == team
    end
    
    it 'should figure out comment text based upon step type' do
      step = Factory(:step)
      team = Factory(:team)
      comment = Factory(:comment, :commentable => step, :team => team )
      comment.commentable.should == step
      comment.team.should == team
    end

    pending 'resource'

  end
end
