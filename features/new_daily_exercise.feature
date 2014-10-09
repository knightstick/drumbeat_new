Feature: Get a new practice routine
  Background:
    Given I am logged in
    And there are 2 additional exercises
    Given Random Exercise returns 2

    
    Scenario: Practice routine
      When I click the "Practice Routine" link
      Then I should see "Daily Exercise"
      And I should see "Single Stroke 2"