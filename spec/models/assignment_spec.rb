# == Schema Information
#
# Table name: assignments
#
#  id           :integer          not null, primary key
#  scorecard_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Assignment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
