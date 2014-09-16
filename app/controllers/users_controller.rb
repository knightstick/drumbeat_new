class UsersController < ApplicationController
  before_action :login_required, except: [:new, :create]
  
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
  
  def assign_daily
    # pick an exercise from the collection
    random_exercise = Exercise.random_exercise
    # if a scorecard exists for the current user, redirect to scorecard
    scorecard = Scorecard.find_by(user_id: current_user.id, 
                                exercise_id: random_exercise.id)
    if  scorecard
      redirect_to "/users/#{current_user.id}/scorecards/#{scorecard.id}"
    # else create scorecard and redirect
    else
      new_card = Scorecard.create!(user_id: current_user.id, exercise_id: random_exercise.id)
      redirect_to "/users/#{current_user.id}/scorecards/#{new_card.id}"
    end
  end
  
  def daily_exercise_assign
    @user = current_user
    @user.set_daily_exercise
    
    scorecard = Scorecard.find_by(user_id: current_user.id, 
                                exercise_id: @user.daily_exercise)
    if  scorecard
      redirect_to "/users/#{current_user.id}/scorecards/#{scorecard.id}"
    # else create scorecard and redirect
    else
      new_card = Scorecard.create!(user_id: current_user.id, exercise_id: @user.daily_exercise)
      redirect_to "/users/#{current_user.id}/scorecards/#{new_card.id}"
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
