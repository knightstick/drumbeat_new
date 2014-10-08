class RoutinesController < ApplicationController
	def show
		if current_user.routine.present?
			@routine = current_user.routine
		else
			@routine = Routine.create(user: current_user)
		end
	end

	def create
		@routine = Routine.new(user: current_user)
		if @routine.save
			render 'show'
		else
			render json: 'something went wrong'
		end
	end
end
