class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:notice] = "Logged in"
      session[:user_id] = @user.id
      
      redirect_to @user
    else
      flash[:error] = "There was an error."
      redirect_to "/"
    end
    
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been logged out successfully"
    redirect_to "/"
  end
end
