Feature: Sign in
	Scenario: Register a new User
		Given there is an Exercise
		When I visit the "signup" page
		And I fill in my signup details
		And I click the "Sign Up" button
		Then I should see "New user created"
		And I should see "Quick Practice"
		And I should see "Practice Routine"