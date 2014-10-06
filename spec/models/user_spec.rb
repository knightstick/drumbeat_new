require 'rails_helper'

RSpec.describe User, :type => :model do
  
  describe "User#no_scores?" do
	  before(:each) do
	  	Exercise.create!(id: 1, name: "Single Stroke Roll")
	  	@user =  User.create!(name: "User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
	  end

	  it "A User with no scores should return true" do
	  	expect(@user.no_scores?).to eq true
	  end

	  it "A User with a score should return false" do
	  	Scorecard.find_or_create_by(user_id: @user.id, exercise_id: 1, score4: 120)
	  	expect(@user.no_scores?).to eq false
	  end
  end

  describe "Scorecard#Assign" do
    before(:each) do
      Exercise.create!(id: 1, name: "Single Stroke Roll")
      Exercise.create!(id: 2, name: "Double Stroke Roll")
      Exercise.create!(id: 3, name: "Triple Stroke Roll")
      allow(Exercise).to receive(:random_exercise).and_return Exercise.find(3)
      @user =  User.create!(name: "User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
      @user.daily_exercise = 2
      @user.save
    end

    it "should assign a new daily exercise" do
      @user.assign_scorecard
      expect(@user.daily_exercise).to eq 3
    end

    it "should assign a given daily exercise" do
      @user.assign_scorecard(exercise: 1)
      expect(@user.daily_exercise).to eq 1
    end

    it "should assign a new weekly exercise" do
    	@user.assign_scorecard(timeframe: 'weekly')
    	expect(@user.weekly_exercise).to eq 3
    end

    it "should assign a given weekly exercise" do 
    	@user.assign_scorecard(timeframe: 'weekly', exercise: 1)
    	expect(@user.weekly_exercise).to eq 1
    end

    it "should assign a new monthly exercise" do
    	@user.assign_scorecard(timeframe: 'monthly')
    	expect(@user.monthly_exercise).to eq 3
    end

    it "should assign a given monthly exercise" do 
    	@user.assign_scorecard(timeframe: 'monthly', exercise: 1)
    	expect(@user.monthly_exercise).to eq 1
    end
  end
end
