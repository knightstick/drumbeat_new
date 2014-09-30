Feature: My scores by link
  Background:
    Given I am logged in
    
  Scenario: View all scores
    Given I have scored an exercise
    And I click the link "My Scores"
    Then I should see "Single Stroke Roll"
    And I should see "120"