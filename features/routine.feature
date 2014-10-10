Feature: Get a routine
	Background:
		Given I am logged in
		Given 3 Exercises exist

		Scenario: Click the Routine button
			When I click the "Practice Routine" link
			Then I should see "Single Stroke"