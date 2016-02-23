@vcr
Feature: Save occupations
  As a job seeker
  I want to save a list of interesting occupations
  So that I can refer back to them during my work search

Scenario: Save an interesting occupation
  Given I have viewed the details of a specific occupation
  When I save the occupation
  Then it should appear in my list of saved occupations

@javascript
Scenario: Save an interesting occupation on a javascript-enabled device
  Given I have viewed the details of a specific occupation
  When I save the occupation
  Then I should see an in-situ confirmation that the occupation is saved
  And it should appear in my list of saved occupations
