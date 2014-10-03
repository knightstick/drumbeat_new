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
end
