@vcr
Feature: Search
  As a job seeker
  I want to explore work that I might do
  So that I can progress my work search

Scenario: Search for SOC occupations
  Given I am on the search page
  When I search for something work related
  Then I should see SOC occupations related to my search term

Scenario: View details for a search result
  Given I have searched for something work related
  When I drill into a specific search result
  Then I should see all of its details

Scenario: Perform searches directly from search results
  Given I have searched for something work related
  When I search for something else work related
  Then I should see SOC occupations related to my search term
