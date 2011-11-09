class Users::SessionsController < ApplicationController
  def new
    @signin_data = SignInData.new
  end

  def create
    @signin_data = SignInData.new(params[:sign_in_data])
    render(:action => :new) and return unless @signin_data.valid?
    if params[:join_team_id]
      session[:join_team_id] = params[:join_team_id]
    end
    session[:login_email] = @signin_data.email
    redirect_to "/auth/#{@signin_data.provider}"
  end
end
