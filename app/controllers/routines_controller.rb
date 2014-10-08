class RoutinesController < ApplicationController
	def show
		if current_user
			@routine = current_user.routine
		else
			@routine = Routine.create(user: current_user)
			current_user.routine = @routine
		end
	end

	def create
		current_user.routine = nil
		@routine = Routine.new(user: current_user)
		current_user.routine = @routine
		if @routine.save
			redirect_to '/me/routine'
		else
			render json: 'something went wrong'
		end
	end
end
