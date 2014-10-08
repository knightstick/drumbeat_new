# == Schema Information
#
# Table name: scorecards
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  exercise_id :integer
#  score4      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  score60     :integer
#  score5      :integer
#

require 'test_helper'

class ScorecardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
