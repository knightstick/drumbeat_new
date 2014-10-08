# == Schema Information
#
# Table name: assignments
#
#  id           :integer          not null, primary key
#  scorecard_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Assignment < ActiveRecord::Base
  belongs_to :scorecard
  belongs_to :routine

  def exercise
  	Exercise.find(scorecard_id)
  end
end
