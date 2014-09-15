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
    @scorecard.update(score4: params[:score4]) unless params[:score4].blank?
    @scorecard.update(score60: params[:score60]) unless params[:score60].blank?
    @scorecard.update(score5: params[:score5]) unless params[:score5].blank?

    redirect_to "/users/#{current_user.id}/scorecards/#{@scorecard.id}"
  end
end
