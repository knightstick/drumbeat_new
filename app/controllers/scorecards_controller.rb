class ScorecardsController < ApplicationController
  before_action :login_required
  
  
  def show
    @user = User.find(params[:user_id])
    @scorecard = Scorecard.find(params[:id])
  end
  
  def index
    @scorecards = Scorecard.where(user_id: current_user)
  end
  
  def update
    @scorecard = Scorecard.find(params[:id])
    @scorecard.submit_score(score4: params[:score4], score60: params[:score60], score5: params[:score5])

    respond_to do |format| 
      format.html { redirect_to request.referrer }
      format.js
    end
  end
  
  def reset
    @scorecard = Scorecard.find(params[:id])
    @scorecard.reset_scores
    redirect_to profile_path
  end
end
