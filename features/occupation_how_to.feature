@vcr
Feature: How to use occupations
  As a job seeker
  I want to understand the roles i'm interested in
  So I can use the information in a more effective way

  Scenario: Save interesting occupation from How To
    Given I have viewed the details of a specific occupation
    When I explore how to use the occupation
    And I save the occupation
    Then I should see a confirmation that the occupation is saved
    And it should appear in my list of saved occupations

  Scenario: View an occupation how to
    Given I have viewed the details of a specific occupation
    When I explore how to use the occupation
    Then I should see how to use the occupation

  @javascript
  Scenario: Save an interesting occupation from How To on a javascript-enabled device
    Given I have viewed the details of a specific occupation
    When I explore how to use the occupation
    And I save the occupation
    Then I should see on the How To page that the occupation is saved
    And it should appear in my list of saved occupations
