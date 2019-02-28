def search_for(query)
  self.current_search_query = query

  within("#search-form") do
    fill_in("query", with: current_search_query)
    find("input[type=submit]").click
  end
end

Given(/^I am on the search page$/) do
  visit new_scrapbook_search_path(scrapbook_id: scrapbook_id)
end

Given(/^I have searched for something work related$/) do
  step("I am on the search page")
  step("I search for something work related")
end

When(/^I (?:drill|have drilled) into a specific search result$/) do
  click_link specific_search_result.fetch(:title)
end

When(/^I search for something( else)? work related$/) do |other|
  query = if other
            other_work_related_search_query
          else
            work_related_search_query
          end

  search_for(query)
end

When(/^I search for something that returns no results$/) do
  search_for("gobbledygook")
end

When(/^I search with no search query$/) do
  search_for("")
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
    element = find("[id^=occupation-#{attribute.to_s.tr('_', '-')}-]")
    expect(element).to have_content(specific_search_result[attribute])
  end
end

Then(/^I should see SOC occupations related to my search term$/) do
  expected_search_results = search_results_for(current_search_query)
  expected_search_results.each do |search_result|
    expect(page).to have_text(search_result.fetch(:title))
    expect(page).to have_text(search_result.fetch(:description))
  end
end
