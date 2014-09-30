Feature: Log in
	Scenario: See daily exercise
		Given there is an Exercise
		And there is a User
		When I visit the "login" page
		And I fill in my details
		And I click the "Log in" button
		Then I should see "Single Stroke Roll"