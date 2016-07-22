Feature: Health check
  As a devleoper
  In order to know when the site is unavailable
  I want a health check that tells me it is up

Scenario: /health_check
  When I check /health_check
  Then I should see that the site is healthy

Scenario: RAILS_RELATIVE_URL_ROOT/health_check
  When I check RAILS_RELATIVE_URL_ROOT/health_check
  Then I should see that the site is healthy
