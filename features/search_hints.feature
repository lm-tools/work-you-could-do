@vcr
Feature: Search hints
  As a job seeker
  In order to understand how I might search
  I want to see search hints in relevant places

Scenario: Show on new search
  When I am on the search page
  Then I should see search hints

Scenario: Show on searches with no results
  Given I am on the search page
  When I search for something that returns no results
  Then I should see search hints

Scenario: Show on searches with no search query
  Given I am on the search page
  When I search with no search query
  Then I should see search hints

Scenario: Do not show on searches with results
  Given I am on the search page
  When I search for something work related
  Then I should not see search hints
