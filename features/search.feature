@wip
Feature: Search
  As a job seeker
  I want to explore work that I might do
  So that I can progress my work search

Scenario Outline: Search for SOC occupations
  Given I am on the search page
  When I search for <search term>
  Then I should see soc occupations related to <search term>

  Examples:
    | search term |
    | library     |
    | driving     |
