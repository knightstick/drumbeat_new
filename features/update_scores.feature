Feature: Update Scores
	Background:
		Given I am logged in
		Given 3 Exercises exist
		Given I have a routine with exercises "1,2,3"



		Scenario: Update random Scorecard 
			Given Random Exercise returns 1
			When I click the "Quick Practice" link
			And I fill in "single-stroke-1-score4" with "120"
			And I click the "Update score" button
			And I refresh the page
			Then the "single-stroke-1-score4" field should show "120"

		Scenario: Update routine Scorecard
			When I click the "Practice Routine" link
			And I fill in "single-stroke-1-score4" with "130"
			And I click the "single-stroke-1-update" button
			And I refresh the page
			Then the "single-stroke-1-score4" field should show "130"	
