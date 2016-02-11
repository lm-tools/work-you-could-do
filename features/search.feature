@vcr
Feature: Search
  As a job seeker
  I want to explore work that I might do
  So that I can progress my work search

Scenario: Search for SOC occupations
  Given I am on the search page
  When I search for something work related
  Then I should see SOC occupations related to my search term
