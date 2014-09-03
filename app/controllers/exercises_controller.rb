class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.all
  end
  
  def show
    @exercise = Exercise.find(params[:id])
  end
  
  def assign
    rand_id = rand(1..Exercise.count)
    @exercise = Exercise.find(rand_id)
    redirect_to @exercise
  end
  

end
