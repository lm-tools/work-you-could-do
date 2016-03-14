require "rspec/matchers"
require "capybara"

RSpec::Matchers.define :have_analytics_event do |expected|
  def wait_until(timeout_in_seconds = Capybara.default_max_wait_time)
    Timeout.timeout(timeout_in_seconds) do
      sleep(0.1) until (value = yield)
      value
    end
  end

  match do |page|
    # rubocop:disable Lint/HandleExceptions
    begin
      wait_until do
        @analytics_events = Array(page.evaluate_script("window.dataLayer"))
        @analytics_events.include?(expected)
      end
    rescue Timeout::Error
      # Do nothing, the actual expectation is run below
    end

    expect(@analytics_events).to include(expected)
  end

  failure_message do
    <<-EOT
      actual analytics events:
        #{@analytics_events}
      were expected to include:
        #{expected}
    EOT
  end
end
