When(/^I progress from the introduction$/) do
  visit scrapbook_introduction_path(scrapbook_id: scrapbook_id)
  click_on("next")
end
