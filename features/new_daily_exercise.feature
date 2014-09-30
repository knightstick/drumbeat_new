Feature: Choose a new daily exercise
  Background:
    Given I am logged in
    And there are 2 additional exercises
    Given Random Exercise returns 2

    
    Scenario: Click 'Give me a new one'
      When I click the link "Give me a new one"
      Then I should see "Single Stroke 2"