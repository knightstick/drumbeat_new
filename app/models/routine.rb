# == Schema Information
#
# Table name: routines
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Routine < ActiveRecord::Base
	belongs_to :user
	has_many :assignments
	
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
end
