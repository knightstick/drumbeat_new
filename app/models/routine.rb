# == Schema Information
#
# Table name: routines
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Routine < ActiveRecord::Base
	belongs_to :user
	has_many :assignments

	before_create :pre_assign
	
	def current(timeframe = nil)
		if timeframe
			Assignment.where(routine: self, timeframe: timeframe).last
		else
			Assignment.where(routine: self)
		end
	end

	def method_missing(name, *args)
		if name =~ /\Adaily\z/ || name =~ /\Aweekly\z/ || name =~ /\Amonthly\z/
			current(name)
		else
			super
		end
	end

	def pre_assign
		scorecards = []
		3.times { scorecards << Scorecard.find_or_create_by(user: self.user, exercise: Exercise.random_exercise)}
		timeframes = ['daily', 'weekly', 'monthly']
		timeframes.each_with_index do |timeframe, i|
			self.assignments.new(routine_id: self, timeframe: timeframe,
				scorecard: scorecards[i]).id
		end
	end

	def assign(options = {})
		if options[:timeframe]
			if options[:exercise].present?
				scorecard = Scorecard.find_or_create_by(user: self.user, exercise_id: options[:exercise])
			else 
				scorecard = Scorecard.find_or_create_by(user: self.user, exercise: Exercise.random_exercise)
			end
			self.assignments.create(timeframe: options[:timeframe], scorecard: scorecard)
		else
			return false
		end
	end	
end
