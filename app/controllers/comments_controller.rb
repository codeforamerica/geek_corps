class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @comment =  Comment.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'Comment added!'
      redirect_to @comment.commentable
    else
      flash[:alert] = 'We had a problem adding that comment'
      redirect_to @comment.commentable            
    end
  end

end
