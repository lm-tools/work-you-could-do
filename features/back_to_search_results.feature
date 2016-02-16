@vcr
Feature: Back to search results
  As a job seeker
  I want to return to a set of search results without searching again
  So that I can easily explore search results

Background:
  Given I have searched for something work related
  And I have drilled into a specific search result

Scenario: Return to search results after viewing details for a specific result
  When I return to the search results
  Then I should see SOC occupations related to my search term

Scenario: Return to search results after saving an occupation
  Given I have saved the occupation
  When I return to the search results
  Then I should see SOC occupations related to my search term

Scenario: Remember search query through returning from saving
  Given I have saved the occupation
  And I have returned to the specific search result's details
  When I return to the search results
  Then I should see SOC occupations related to my search term
