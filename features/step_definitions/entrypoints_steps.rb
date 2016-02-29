Given(/^I have an existing scrapbook$/) do
  scrapbook = Scrapbook.create(id: scrapbook_id)
  search_results_for(work_related_search_query).each do |result|
    scrapbook.occupations << Occupation.find_or_import_from_lmi(result[:soc])
  end
end

When(/^I access the tool with my scrapbook identifier$/) do
  visit root_url(id: scrapbook_id)
end

When(/^I access the tool without a scrapbook identifier$/) do
  visit root_url
end

Then(/^I should see the new search page, within my scrapbook$/) do
  expect(current_path).to eq(
    new_scrapbook_search_path(scrapbook_id: scrapbook_id)
  )
end

Then(/^I should see the new search page, within a new scrapbook$/) do
  routing = Rails.application.routes.recognize_path(current_path)

  expect(routing[:controller]).to eq("searches")
  expect(routing[:action]).to eq("new")
  expect(routing[:scrapbook_id]).to match(Scrapbook::VALID_ID)
end

Then(/^I should see my scrapbook$/) do
  expect(current_path).to eq scrapbook_path(id: scrapbook_id)
end
