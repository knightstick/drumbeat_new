require 'rails_helper'

RSpec.describe Exercise, :type => :model do
  it "should be valid" do
  	roll = Exercise.new(name: "Single Stroke Roll")
  	expect(roll).to be_valid
  end

  it "should not be valid without name" do
  	no_name = Exercise.new(name: " ")
  	expect(no_name).to_not be_valid
  end

  describe "Exercise#Random_Exercise" do 
  	before(:each) do
  		Exercise.create!(name: "Single Stroke Roll")
  		Exercise.create!(name: "Double Stroke Roll")
  	end

  	it "should return an exercise" do 
  		expect(Exercise.random_exercise).to be_an_instance_of(Exercise)
  	end

  	it "should not return nil if an exercise is deleted" do 
  		allow(Kernel).to receive(:rand).and_return 0
  		Exercise.find(1).destroy!
  		expect(Exercise.random_exercise).to_not be_nil
  	end
  end
end
