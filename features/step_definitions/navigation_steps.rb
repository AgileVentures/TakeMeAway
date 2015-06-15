def path_to(page_name, id = '')
  name = page_name.downcase
  case name
    when 'home' then
      root_path
    when 'login' then
      new_user_session_path
    when 'dashboard' then
      admin_dashboard_path
    when 'activeadmin root'
      admin_root_path
    when 'products' then
      admin_products_path
    when 'menus' then
      admin_menus_path
    when 'orders' then
      admin_orders_path
    when 'admins' then
      admin_admins_path
    when 'edit admin'then
      edit_admin_admin_path
    else
      raise('path to specified is not listed in #path_to')
  end
end


Then /^I should be on the "([^"]*)" page$/ do |page|
  expect(current_path).to eq path_to(page)
end

Given /^I am on the "([^"]*)" page$/ do |page|
  visit path_to(page)
end

Then(/^I should be on the edit page for user "([^"]*)"$/) do |user_name|
  user = User.find_by(name: user_name)
  expect(current_path).to eq edit_admin_admin_path(user)
end

Then(/^I should be on the view page for user "([^"]*)"$/) do |user_name|
  user = User.find_by(name: user_name)
  expect(current_path).to eq admin_admin_path(user)
end

Then(/^I should be on the edit page for Menu Item "([^"]*)"$/) do |item|
  product = MenuItem.find_by(name: item)
  expect(current_path).to eq edit_admin_product_path(product)
end

Then(/^I should be on the view page for Menu Item "([^"]*)"$/) do |item|
  product = MenuItem.find_by(name: item)
  expect(current_path).to eq admin_product_path(product)
end

Then(/^I should be on the edit page for Menu "([^"]*)"$/) do |item|
  menu = Menu.find_by(title: item)
  expect(current_path).to eq edit_admin_menu_path(menu)
end

Then(/^I should be on the view page for Menu "([^"]*)"$/) do |item|
  menu = Menu.find_by(title: item)
  expect(current_path).to eq admin_menu_path(menu)
end

Then(/^I should be on the view page for Order "([^"]*)"$/) do |item|
  id = item.partition('#').last
  order = Order.find(id)
  expect(current_path).to eq admin_order_path(order)
end

Then(/^I should be on the edit page for Order "([^"]*)"$/) do |item|
  id = item.partition('#').last
  order = Order.find(id)
  expect(current_path).to eq edit_admin_order_path(order)
end
