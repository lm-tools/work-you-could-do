Given(/^I am on the search page$/) do
  visit root_path
end

When(/^I search for something work related$/) do
  within("#search-form") do
    fill_in("query", with: work_related_search_term)
    find("input[type=submit]").click
  end
end

Then(/^I should see SOC occupations related to my search term$/) do
  expected_search_results.each do |search_result|
    expect(page).to have_text(search_result[:title])
  end
end
