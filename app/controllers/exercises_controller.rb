class ExercisesController < ApplicationController
  before_action :login_required
  
  def index
    @tiers = Exercise.tiered
  end
  
  def show
    @user = current_user
    @exercise = Exercise.find(params[:id])
    @scorecard = Scorecard.find_or_create_by(
    								user: current_user, exercise: @exercise)
  end
end
