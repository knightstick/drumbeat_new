Given(/^I have scored an exercise$/) do
  scorecard = Scorecard.find_or_create_by(exercise_id: 1, user_id: @user.id)
  scorecard.submit_score(score4: 120)
end
