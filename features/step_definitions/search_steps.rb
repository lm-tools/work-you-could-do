Given(/^I am on the search page$/) do
  visit root_path
end

Given(/^I have searched for something work related$/) do
  step("I am on the search page")
  step("I search for something work related")
end

When(/^I drill into a specific search result$/) do
  click_link specific_search_result[:title]
end

When(/^I search for something work related$/) do
  within("#search-form") do
    fill_in("query", with: work_related_search_term)
    find("input[type=submit]").click
  end
end

Then(/^I should see all of its details$/) do
  attributes = %i(title
                  description
                  tasks
                  qualifications
                  additional_titles
                  week_hours
                  week_pay)

  attributes.each do |attribute|
    element = find("#occupation-#{attribute.to_s.tr('_', '-')}")
    expect(element).to have_content(specific_search_result[attribute])
  end
end

Then(/^I should see SOC occupations related to my search term$/) do
  expected_search_results.each do |search_result|
    expect(page).to have_text(search_result[:title])
  end
end
