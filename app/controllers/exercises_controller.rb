class ExercisesController < ApplicationController
  before_action :login_required
  
  def index
    @tiers = Exercise.tiered
  end
  
  def show
    @user = current_user
    @exercise = Exercise.find(params[:id])
    @scorecard = Scorecard.find_or_create_by(exercise_id: @exercise.id, user_id: current_user.id)
  end
  
  def assign
    rand_id = rand(1..Exercise.count)
    @exercise = Exercise.find(rand_id)
    redirect_to @exercise
  end
  

end
