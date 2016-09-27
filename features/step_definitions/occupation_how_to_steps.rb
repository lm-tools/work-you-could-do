When(/^I explore how to use the occupation$/) do
  click_on("occupation-how-to")
end

Then(/^I should see how to use the occupation$/) do
  view_occupation_how_to_path = \
    scrapbook_occupation_how_to_path(
      scrapbook_id: scrapbook_id,
      soc_code: specific_search_result.fetch(:soc)
    )
  expect(current_path).to eq view_occupation_how_to_path
end

Then(/^I should see on the How To page that the occupation is saved$/) do
  view_occupation_how_to_path = \
    scrapbook_occupation_how_to_path(
      scrapbook_id: scrapbook_id,
      soc_code: specific_search_result.fetch(:soc)
    )
  expect(current_path).to eq view_occupation_how_to_path

  saved_occupations_path = scrapbook_saved_occupations_path(
    scrapbook_id: scrapbook_id
  )

  expect(page).to have_analytics_event(
    {
      "event" => "pageView",
      "virtualPageViewPath" => saved_occupations_path,
    }
  )

  step("I should see a confirmation that the occupation is saved")
end
