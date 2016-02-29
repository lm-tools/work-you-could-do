Given(/^I am viewing my scrapbook$/) do
  visit scrapbook_path(id: scrapbook_id)
end

When(/^I remove one of my saved occupations$/) do
  click_on("remove-occupation-#{specific_search_result[:soc]}")
end

Then(/^I should see a confirmation that the occupation is removed$/) do
  confirmation_message = "#{specific_search_result.fetch(:title)} removed"
  expect(page).to have_content(confirmation_message)
end

Then(/^I should see an in-situ confirmation that the occupation is removed$/) do
  expect(current_path).to eq scrapbook_path(id: scrapbook_id)
  step("I should see a confirmation that the occupation is removed")
end

Then(/^it should not appear in my list of saved occupations$/) do
  click_on("scrapbook")
  expect(page).to have_no_content(specific_search_result.fetch(:title))
end

Then(/^it should be removed in-situ$/) do
  expect(page).to \
    have_no_xpath("//h2[text() = '#{specific_search_result.fetch(:title)}']")
end
