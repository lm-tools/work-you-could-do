When(%r{^I check /health_check$}) do
  visit "/health_check"
end

When(%r{^I check RAILS_RELATIVE_URL_ROOT/health_check$}) do
  visit "#{Rails.application.config.relative_url_root}/health_check"
end

Then(/^I should see that the site is healthy$/) do
  body = JSON.parse(page.body)
  expect(body).to eq({ "status" => "ok", "database" => "up" })
end
