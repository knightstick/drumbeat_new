class UsersController < ApplicationController
  before_action :login_required, except: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @user.assign_daily
    @scorecard = @user.daily_scorecard
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
  
  def assign_daily
    @user = current_user
    redirect_to "/"
  end
  
  def assign_new_daily
    @user = current_user
    @user.assign_daily(assign: true)
    redirect_to root_path
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
