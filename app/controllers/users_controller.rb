class UsersController < ApplicationController
  before_action :login_required, except: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def profile
    @user = current_user
    @scorecard = Scorecard.get(@user.daily_exercise, @user.id)
  end

  def create
    @user = User.make(user_params)
    if @user.save
      flash[:success] = "New user created!"
      session[:user_id] = @user.id
      @user.daily_scorecard
      redirect_to "/profile"
    else
      flash[:error] = "ERROR"
      render "new"
    end
  end
  
  def assign_new_daily
    @user = current_user
    @user.assign_daily(assign: true)
    redirect_to root_path
  end

  def assign
    @user = current_user
    @user.assign_daily(assign: true, exercise: params[:id])
    redirect_to root_path
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
