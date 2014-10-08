class ExercisesController < ApplicationController
  before_action :login_required
  
  def index
    @tiers = Exercise.tiered
  end
  
  def show
    @user = current_user
    @exercise = Exercise.find(params[:id])
  end
end
