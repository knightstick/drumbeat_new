Given(/^I have scored an exercise$/) do
  scorecard = Scorecard.get(1, @user.id)
  scorecard.submit_score(score4: 120)
end
