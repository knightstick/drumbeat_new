class RoutinesController < ApplicationController
	def show
		@routine = current_user.routine
	end

end
