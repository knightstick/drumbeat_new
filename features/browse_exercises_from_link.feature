Feature: Browse All Exercises from link
  Background:
    Given I am logged in
    And I click the link "All Exercises"
    
    Scenario: See link for Single Stroke Roll
      Then I should see "Single Stroke Roll"