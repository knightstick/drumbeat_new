class RegimeController < ApplicationController
  
  def create
  	current_user.regime.delete
  	current_user.regime = Regime.new(daily: Exercise.random_exercise.id)
  	redirect_to regime_path
  end

  def show
  	regime = current_user.regime
  	begin
	  	daily = Scorecard.find(regime.daily)
	  	if regime.weekly
	  		weekly = Scorecard.find(regime.weekly)
  		end
  		if regime.monthly
  			monthly = Scorecard.find(regime.monthly)
  		end
	  	@regime = [daily, weekly, monthly]
	  	flash[:notice] = "Got to the end"
  	rescue
  		@regime = []
  		flash[:notice] = "Rescued..."
  	end
  end

  def update
  end

  def destroy
  end
end
