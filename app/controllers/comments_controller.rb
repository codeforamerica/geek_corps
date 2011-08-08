class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @comment =  Comment.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Comment added!'
      redirect_to :back
    else
      flash[:error] = 'We had a problem adding that comment'
      redirect_to :back            
    end
  end

end
