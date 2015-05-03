Then(/^show me the page$/) do
  save_and_open_page
end

Given(/^I (?:visit|am on) the site$/) do
  visit root_path
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

When(/^(?:when I|I) click "([^"]*)"$/) do |text|
  click_link_or_button text
end

When(/^I click "([^"]*)" button$/) do |button|
  click_button button
end

When(/^I click the "([^"]*)" link$/) do |link|
  click_link link
end

When(/^I focus on input field with id "([^"]*)"$/) do |element|
  id = element.downcase.tr!(' ', '_')
  page.execute_script "$('##{id}').focus();"
end

Then /^I should( not)? see "([^"]*)"$/ do |negative, string|
  unless negative
    expect(page).to have_text string
  else
    expect(page).to_not have_text string
  end
end

Then /^I should( not)? see link "([^"]*)"$/ do |negative, link|
  unless negative
    expect(page).to have_link link
  else
    expect(page).to_not have_link link
  end
end

And(/^I select the date "([^"]*)" in datepicker for ([^"]*)$/) do |date, element|
  id = element.downcase.tr!(' ', '_')
  page.execute_script "$('input.date-time-picker##{id}').val('#{date}');"
end