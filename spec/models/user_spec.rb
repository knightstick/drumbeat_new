# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  name            :string(255)
#

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

  describe "User#needs_new?" do

    before(:each) do
      Exercise.create!(id: 1, name: "Single Stroke Roll")
      Exercise.create!(id: 2, name: "Double Stroke Roll")
      Exercise.create!(id: 3, name: "Triple Stroke Roll")
      @user =  User.create!(name: "User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
      @user.daily_exercise = 1
      @user.save
    end

    describe "daily" do 
      it "should return false if recently updated" do
        expect(@user.needs_new?). to eq false
      end

      it "should return true if updated over a day ago" do
        @user.daily_updated_at = 25.hours.ago
        expect(@user.needs_new?).to eq true
      end

      it "needs_new_daily? should be callable" do
        expect(@user.needs_new_daily?).to eq(false)
      end

      it "should return true if updated over a day ago" do
        @user.daily_updated_at = 25.hours.ago
        expect(@user.needs_new_daily?).to eq true
      end
    end

    describe "weekly" do 
      before(:each) do
        @user.weekly_updated_at = Time.now
      end

      it "timeframe should return false if updated within the last week" do
        expect(@user.needs_new?(timeframe: 'weekly')).to eq false
      end

      it "weekly should return false if updated within the last week" do
        expect(@user.needs_new_weekly?).to eq false
      end

      it "weekly should return false if updated a few days ago" do
        @user.weekly_updated_at = 3.days.ago
        expect(@user.needs_new_weekly?).to eq false
      end

      it "timeframe should return false if updated a few days ago" do
        @user.weekly_updated_at = 3.days.ago
        expect(@user.needs_new?(timeframe: 'weekly')).to eq false
      end      

      it "timeframe should return true if updated over a week ago" do
        @user.weekly_updated_at = 8.days.ago
        expect(@user.needs_new?(timeframe: 'weekly')).to eq true
      end

      it "weekly should return true if updated over a week ago" do
        @user.weekly_updated_at = 8.days.ago
        expect(@user.needs_new_weekly?).to eq true
      end
    end

    describe "monthly" do
      before(:each) do
        @user.monthly_updated_at = Time.now
      end

      it "should return false if updated within the last month" do
        expect(@user.needs_new?(timeframe: 'monthly')).to eq false        
      end

      it "should return false if updated a day ago" do
        @user.monthly_updated_at = 30.hours.ago
        expect(@user.needs_new_monthly?).to eq false 
      end

      it "should return false if updated 2 weeks ago" do 
        @user.monthly_updated_at = 2.weeks.ago
        expect(@user.needs_new?(timeframe: 'monthly')).to eq false
      end

      it "should true if updated over a month ago" do
        @user.monthly_updated_at = 2.months.ago
        expect(@user.needs_new_monthly?).to eq true
      end
    end
  end
end
