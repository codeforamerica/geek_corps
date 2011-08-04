require 'spec_helper'

describe CommentsController do

  describe "post 'create'" do
    
    before do
      @user = Factory(:user)
      sign_in(@user)
      @comment = Factory(:comment)
    end

    
    it "should be post to comments and redirect with success" do
      post 'create', :comment => Factory.attributes_for(:comment, :team => @comment.team, :user => @user, :commentable => @comment.commentable )
      flash[:notice].should == 'Comment added!'
      response.should redirect_to @comment.commentable 
    end
    
    it "should be post to comments and redirect with error" do
      post 'create',:comment => Factory.attributes_for(:comment, :team => @comment.team, :commentable => @comment.commentable , :user => nil)
      flash[:alert].should == 'We had a problem adding that comment'
      response.should redirect_to @comment.commentable
    end
    
  end
  
    describe "not signed in" do
      
      before do
        @comment = Factory(:comment)
      end
      
      it "should not be successful" do
      post 'create', :comment => Factory.attributes_for(:comment, :team => @comment.team, :user => @comment.user, :commentable => @comment.team)
        response.should redirect_to new_user_session_path
      end
      
    end
    
end
