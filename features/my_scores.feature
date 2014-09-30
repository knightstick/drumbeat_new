Feature: My Scores - Scorecards index
  Background:
    Given I am logged in
  
  Scenario: Without any scorecards see no score message
    When I visit the "scorecards" page
    Then I should see "You've not set any scores yet."
  
  Scenario: With scorecards see scores
    Given I have scored an exercise
    And I visit the "scorecards" page
    Then I should see "Single Stroke Roll"
    
    
  
  
  