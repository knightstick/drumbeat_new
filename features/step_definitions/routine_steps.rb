Given(/^I have a routine with exercises "(.*?)"$/) do |array|
	array = array.split(",")
	RoutinesController.skip_before_filter :pre_assign
	routine = Routine.create!
	scorecards = []
	array.each do |ni|
		scorecards << Scorecard.find_or_create_by(user_id: 1, exercise_id: ni)
	end			
	timeframes = ['daily', 'weekly', 'monthly']
	timeframes.each_with_index do |timeframe, i|
		routine.assignments.new(routine: routine, timeframe: timeframe,
			scorecard: scorecards[i]).id
	end
	User.find(1).routine = routine
end

When(/^I pre\-assign a routine with "(.*?)"$/) do |exercises|
	exercises = exercises.split(',').join
	user = User.find(1)
	user.routine = Routine.create!
	routine = user.routine
	routine.pre_assign(exercises)
end

