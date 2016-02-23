Given(/^I have viewed the details of a specific occupation$/) do
  visit scrapbook_occupation_path(scrapbook_id: scrapbook_id,
                                  soc_code: specific_search_result.fetch(:soc))
end

When(/^I (?:save|have saved) the occupation$/) do
  click_on("save-occupation")
end

Then(/^it should appear in my list of saved occupations$/) do
  click_on("scrapbook")
end

Then(/^I should see an in\-situ confirmation that the occupation is saved$/) do
  view_occupation_details_path = \
    scrapbook_occupation_path(scrapbook_id: scrapbook_id,
                              soc_code: specific_search_result.fetch(:soc))

  # confirmation displays in-situ
  expect(current_path).to eq view_occupation_details_path

  confirmation_message = %("#{specific_search_result.fetch(:title)}" saved)
  expect(page).to have_content(confirmation_message)
end
