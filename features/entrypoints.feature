@vcr
Feature: Entrypoints
  As a UCDS user
  I want a persistent scrapbook to be accessible from my UCDS account
  So that I can refer back to it during my work search
  And easily share it with my work coach

Scenario: Access the tool for the first time
  When I access the tool with my scrapbook identifier
  Then I should see the new search page, within my scrapbook

Scenario: Access an existing scrapbook
  Given I have an existing scrapbook
  When I access the tool with my scrapbook identifier
  Then I should see my scrapbook
