class ScorecardsController < ApplicationController
  
  def show
    @user = User.find(params[:user_id])
    @exercise = Scorecard.find(params[:id]).exercise
  end
end
