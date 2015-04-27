Given(/^I (?:visit|am on) the site$/) do
  visit root_path
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