class ScorecardsController < ApplicationController
  before_action :login_required
  
  def create
    @user = current_user
    @scorecard = @user.scorecards.find_or_create_by(exercise_id: params[:exercise])
    redirect_to @scorecard
  end

  def show
    @user = current_user
    @scorecard = @user.scorecards.find(params[:id])
  end

  def random
    exercise = Exercise.random_exercise
    @scorecard = current_user.scorecards.find_or_create_by(exercise: exercise)
    redirect_to @scorecard
  end
  
  def index
    @scorecards = User.find(current_user.id).scorecards
  end
  
  def update
    @user = current_user
    @scorecard = @user.scorecards.find(params[:id])
    @scorecard.submit_score(scorecard_params)

    respond_to do |format| 
      format.html { redirect_to request.referrer }
      format.js { render json: @scorecard }
    end
  end
  
  def reset
    @scorecard = current_user.scorecards.find(params[:id])
    @scorecard.reset_scores
    redirect_to @scorecard
  end

  private
    def scorecard_params
      params.require(:scorecard).permit(:score4, :score60, :score5)
    end
end
