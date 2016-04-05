@allow-rescue
@allow-error-pages
@vcr
Feature: Custom error pages
  In order to not get lost
  As a user
  I want friendly error pages

Scenario: Invalid url outside of a scrapbook
  When I visit a non-existent page
  Then I should see a friendly 404 page

Scenario: Invalid url inside of a scrapbook
  Given I have an existing scrapbook
  When I visit a non-existent page, within my scrapbook
  Then I should see a friendly 404 page, within my scrapbook
