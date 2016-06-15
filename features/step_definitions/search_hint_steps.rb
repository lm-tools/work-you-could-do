Then(/^I should( not)? see search hints$/) do |absent|
  search_hint_selector = "label[for=query] .form-hint"

  if absent
    expect(page).to have_no_selector(search_hint_selector)
  else
    expect(page).to have_selector(search_hint_selector)
  end
end
