Feature: Browse All Exercises by url
  Background:
    Given I am logged in
    And I visit the "exercises" page
    
    Scenario: See link for Single Stroke Roll
      Then I should see "Single Stroke Roll"
    
    Scenario: Show Exercise from index
      When I click the "Single Stroke Roll" link
      Then I should see "Single Stroke Roll"
      And I should see "Try this exercise"
