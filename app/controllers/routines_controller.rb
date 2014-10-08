class RoutinesController < ApplicationController
  before_action :login_required
	
	def show
		if current_user.routine
			@routine = current_user.routine
		else
			@routine = Routine.create(user: current_user)
			current_user.routine = @routine
		end
		@routine.clear_expired
	end

	def create
		current_user.routine = nil
		@routine = Routine.new(user: current_user)
		current_user.routine = @routine
		if @routine.save
			redirect_to '/me/routine'
		else
			flash[:error] = "Something went wrong..."
			redirect_to profile_path
		end
	end

	def update
		current_user.routine.assign(timeframe: params[:timeframe], exercise: params[:exercise])
		redirect_to '/me/routine'
	end
end
