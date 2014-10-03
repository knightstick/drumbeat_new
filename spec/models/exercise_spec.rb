require 'rails_helper'

RSpec.describe Exercise, :type => :model do
  describe "Exercise with no name should not be valid"
  no_name = Exercise.new(name: " ")
  expect(no_name).to_not be_valid
end
