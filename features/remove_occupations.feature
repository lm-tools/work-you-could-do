@vcr
Feature: Remove occupations
  As a job seeker
  I want to maintain a list of interesting occupations
  So that I can refer back to them during my work search

Scenario: Remove a previously saved occupation
  Given I have an existing scrapbook
  And I am viewing my scrapbook
  When I remove one of my saved occupations
  Then I should see a confirmation that the occupation is removed
  And it should not appear in my list of saved occupations

@javascript
Scenario: Remove a previously saved occupation on a javascript-enabled device
  Given I have an existing scrapbook
  And I am viewing my scrapbook
  When I remove one of my saved occupations
  Then I should see an in-situ confirmation that the occupation is removed
  Then it should be removed in-situ
