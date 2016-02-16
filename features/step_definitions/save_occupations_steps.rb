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
