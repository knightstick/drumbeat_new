# == Schema Information
#
# Table name: assignments
#
#  id           :integer          not null, primary key
#  scorecard_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  timeframe    :string(255)
#  routine_id   :integer
#

class Assignment < ActiveRecord::Base
  belongs_to :scorecard
  belongs_to :routine

  def exercise
  	Exercise.find(scorecard.exercise_id)
  end
end
