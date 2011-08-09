require 'spec_helper'

describe CommentsController do

  describe "post 'create'" do
    
    before do
      @user = Factory(:user)
      sign_in(@user)
      @comment = Factory(:comment)
    end

    
    it "should be post to comments and redirect with success" do
      request.env['HTTP_REFERER'] = @comment.commentable.to_url      
      post 'create', :comment => Factory.attributes_for(:comment, :team => @comment.team, :user => @user, :commentable => @comment.commentable )
      flash[:success].should == 'Comment added!'
      response.should redirect_to @comment.commentable.to_url 
    end
    
    it "should be post to comments and redirect with error" do
      request.env['HTTP_REFERER'] = '/' + @comment.team.to_url
      post 'create',:comment => Factory.attributes_for(:comment, :team => @comment.team, :commentable => nil)
      flash[:error].should == 'We had a problem adding that comment'

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
