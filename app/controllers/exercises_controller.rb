class ExercisesController < ApplicationController
  before_action :current_user
  before_action :login_required
  
  def index
    @tiers = Exercise.tiered
  end
  
  def show
    @user = current_user
    @exercise = Exercise.find(params[:id])
    @scorecard = Scorecard.get(@exercise.id, current_user.id)
  end
  
  def assign
    rand_id = rand(1..Exercise.count)
    @exercise = Exercise.find(rand_id)
    redirect_to @exercise
  end
  

end
