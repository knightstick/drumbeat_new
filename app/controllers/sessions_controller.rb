class SessionsController < ApplicationController
  before_action :login_required, only: :destroy
  
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:notice] = "Logged in as #{@user.name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Could not log you in."
      render "new"
    end
    
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been logged out successfully"
    redirect_to root_path
  end
end
