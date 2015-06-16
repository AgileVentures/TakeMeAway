Then(/^show me the page$/) do
  save_and_open_page
end

Given(/^I (?:visit|am on) the site$/) do
  visit root_path
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  case field
    when 'first Daily stock' then
      select_field = 'menu_menu_items_menus_attributes_0_daily_stock'
    when 'second Daily stock' then
      select_field = 'menu_menu_items_menus_attributes_1_daily_stock'
    else
      select_field = field
  end

  fill_in select_field, with: value
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

When(/^I uncheck "([^"]*)"$/) do |checkbox|
  uncheck checkbox
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
  page.execute_script "$('input##{id}').val('#{date}');"
end

When(/^I select "([^"]*)" to "([^"]*)"$/) do |field, option|
  case field
    when 'Menu Item' then
      id = 'menu_menu_item_ids'
    when 'Order Item' then
      id = 'order_item_menu_item_id'
    when 'first Menu Item' then
      id = 'menu_menu_items_menus_attributes_0_menu_item_id'
    when 'second Menu Item' then
      id = 'menu_menu_items_menus_attributes_1_menu_item_id'
  end
  find(:select, id).find(:option, option).select_option
end

When(/^I unselect "([^"]*)" from "([^"]*)"$/) do |option, field|
  case field
    when 'Menu Item' then
      id = 'menu_menu_item_ids'
    when 'Order Item' then
      id = 'order_item_menu_item_id'
    when 'first Menu Item' then
      id = 'menu_menu_items_menus_attributes_0_menu_item_id'
    when 'second Menu Item' then
      id = 'menu_menu_items_menus_attributes_1_menu_item_id'
  end
  find(:select, id).find(:option, option).unselect_option
end

When(/^I attach "([^"]*)" to field "([^"]*)"$/) do |file_name, field|
  path = Rails.root.join('features', 'upload-files', file_name)
  attach_file(field, path)
end

Then(/^I should see the image for Menu Item "([^"]*)"$/) do |name|
  image = MenuItem.find_by(name: name).image
  image_src = page.find("tr.row-image img")["src"]
  expected_src = "http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v#{image.version}/#{image.public_id}.#{image.format}"
  expect(image_src).to eq expected_src
end
