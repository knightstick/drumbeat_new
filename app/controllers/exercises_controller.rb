class ExercisesController < ApplicationController
  before_action :current_user
  
  def index
    @exercises = Exercise.all
  end
  
  def show
    @user = current_user
    @exercise = Exercise.find(params[:id])
  end
  
  def assign
    rand_id = rand(1..Exercise.count)
    @exercise = Exercise.find(rand_id)
    redirect_to @exercise
  end
  

end
