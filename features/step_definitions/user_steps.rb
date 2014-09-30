Given /^there is a User$/ do 
	@user = User.create!(email: 'chris@example.com', name: 'Chris Jewell', password: 'password', 
		password_confirmation: 'password', daily_updated_at: Time.now, daily_exercise: 1)
end

Given /^there is an Exercise$/ do
	Exercise.create!(id: 1, name: "Single Stroke Roll", tier: 1)
end

When /^I fill in my details$/ do
	fill_in "Email", with: "#{@user.email}"
	fill_in "Password", with: "#{@user.password}"
end

When /^I fill in my signup details$/ do
	fill_in "Email", with: "chris@example.com"
	fill_in "Name", with: "Chris Jewell"
	fill_in "Password", with: 'password'
	fill_in "Password confirmation", with: 'password'
end

Given /^I am logged in$/ do
	step %{there is an Exercise}
	step %{there is a User}
	step %{I visit the "login" page}
	step %{I fill in my details}
	step %{I click the "Log in" button}
end