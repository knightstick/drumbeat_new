class ScorecardsController < ApplicationController
  before_action :login_required
  
  
  def show
    @user = current_user
    @scorecard = @user.scorecards.find(params[:id])
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
    @scorecard = Scorecard.find(params[:id])
    @scorecard.reset_scores
    redirect_to profile_path
  end

  def assign
    @user.assign_scorecard(timeframe: params[:timeframe], exercise: params[:exercise])
    redirect_to profile_path
  end

  private
    def scorecard_params
      params.require(:scorecard).permit(:score4, :score60, :score5)
    end
end
