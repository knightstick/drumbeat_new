class UsersController < ApplicationController
  before_action :login_required, except: [:new, :create]
  before_action :current_user
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def profile
    @user = current_user
    @daily_scorecard =   Scorecard.find_or_create_by(exercise_id: @user.daily_exercise,   user_id: @user.id)
    @weekly_scorecard =  Scorecard.find_or_create_by(exercise_id: @user.weekly_exercise,  user_id: @user.id)
    @monthly_scorecard = Scorecard.find_or_create_by(exercise_id: @user.monthly_exercise, user_id: @user.id)
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

  def assign
    if params["timeframe"] == "Today"
      @user.assign_daily(force: true, exercise: (params[:id]))
    elsif params["timeframe"] == "This Week"
      @user.assign_weekly(force: true, exercise: (params[:id]))
    elsif params["timeframe"] == "This Month"
      @user.assign_monthly(force: true, exercise: (params[:id]))
    end
    redirect_to '/profile'
  end
  
  def assign_new_daily
    @user = current_user
    if params[:id].present?
      @user.assign_daily(force: true, exercise: params[:id])
    else
      @user.assign_new_daily
    end
    redirect_to root_path
  end

  def assign_new_weekly
    @user = current_user
    if params[:id].present?
      @user.assign_weekly(force: true, exercise: params[:id])
    else
      @user.assign_new_weekly
    end
    redirect_to root_path
  end

  def assign_new_monthly
    @user = current_user
    if params[:id].present?
      @user.assign_monthly(force: true, exercise: params[:id])
    else
      @user.assign_new_monthly
    end
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
