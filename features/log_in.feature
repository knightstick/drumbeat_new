Feature: Log in
	Scenario: See buttons
		Given there is an Exercise
		And there is a User
		When I visit the "login" page
		And I fill in my details
		And I click the "Log in" button
		Then I should see "Practice Routine"
		
	Scenario: Log out
	  Given I am logged in
	  When I click the "Log Out" link
	  Then I should see "Welcome to Drumbeat"