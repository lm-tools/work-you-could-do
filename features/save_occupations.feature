@vcr
Feature: Save occupations
  As a job seeker
  I want to save a list of interesting occupations
  So that I can refer back to them during my work search

Scenario: Save an interesting occupation
  Given I have viewed the details of a specific occupation
  When I save the occupation
  Then it should appear in my list of saved occupations
