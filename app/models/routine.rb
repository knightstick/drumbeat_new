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
			Assignment.where(routine: self).select(:timeframe).uniq
		end
	end

	def method_missing(name, *args)
		if name =~ /\Adaily\z/ || name =~ /\Aweekly\z/ || name =~ /\Amonthly\z/
			current(name)
		else
			super
		end
	end

	def pre_assign(exercises = nil)
		scorecards = []
		0.upto(2) do |i|
			if exercises
				scorecards << Scorecard.find_or_create_by(user: self.user, exercise: Exercise.find(exercises[i]))
			else
				scorecards << Scorecard.find_or_create_by(user: self.user, exercise: Exercise.random_exercise)
			end
		end
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

	def clear_expired
		expiration_dates = {
			"daily" => 24.hours.ago,
			"weekly" => 7.days.ago,
			"monthly" => 1.month.ago
		}
		expiration_dates.each do |key, value|
			if self.send(key).updated_at < value
				self.assign(timeframe: key)
			end
		end
	end
end
