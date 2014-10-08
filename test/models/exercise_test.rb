# == Schema Information
#
# Table name: exercises
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  sticking   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  image_url  :string(255)
#  tier       :integer
#

require 'test_helper'

class ExerciseTest < ActiveSupport::TestCase

end
