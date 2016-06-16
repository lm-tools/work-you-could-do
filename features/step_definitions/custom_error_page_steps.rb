# rubocop:disable Metrics/LineLength

When(/^I visit a non\-existent page(, within my scrapbook)?$/) do |within_scrapbook|
  if within_scrapbook
    visit "#{scrapbook_path(id: scrapbook_id)}/nonsense"
  else
    visit "#{Rails.application.config.relative_url_root}/nonsense"
  end
end

Then(/^I should see a friendly 404 page(, within my scrapbook)?$/) do |within_scrapbook|
  expect(page).to have_content("This page cannot be found")

  if within_scrapbook
    expect(page).to have_link("scrapbook", href: scrapbook_path(id: scrapbook_id))
    expect(page).to have_link("Introduction", href: scrapbook_introduction_path(scrapbook_id: scrapbook_id))
  else
    expect(page).to have_link("Introduction", href: root_path)
  end
end
