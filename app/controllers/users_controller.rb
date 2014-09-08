class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New user created!"
      session[:user_id] = @user.id
      redirect_to @user
    else
      render "new"
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
