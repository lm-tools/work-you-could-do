Given(/^I have an existing scrapbook$/) do
  scrapbook = Scrapbook.create(id: scrapbook_id)
  expected_search_results(work_related_search_query).each do |result|
    scrapbook.occupations << Occupation.find_or_import_from_lmi(result[:soc])
  end
end

When(/^I access the tool with my scrapbook identifier$/) do
  visit root_url(id: scrapbook_id)
end

Then(/^I should see the new search page, within my scrapbook$/) do
  expect(current_path).to eq(
    new_scrapbook_search_path(scrapbook_id: scrapbook_id)
  )
end

Then(/^I should see my scrapbook$/) do
  expect(current_path).to eq scrapbook_path(id: scrapbook_id)
end
