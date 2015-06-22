Given(/^the following MenuItems exist:$/) do |table|
  table.hashes.each do |hash|
    MenuItem.create!(hash)
  end
end

Given(/^the following Menus exist:$/) do |table|
  table.hashes.each do |hash|
    hash['end_date'] = Date.today if hash['end_date'].empty?
    Menu.create!(hash)
  end
end

Given(/^the following users exist:$/) do |table|
  table.hashes.each do |hash|
    User.create!(hash)
  end
end

And(/^the following Orders exist:$/) do |table|
  table.hashes.each do |hash|
    params = Rack::Utils.parse_nested_query(hash.to_query)
    order_params = params['order']
    user_params = params['user']
    menu_items_params = params['order_items']
    user = User.find_by(name: user_params['user'])
    order_params.merge!('user_id' => user.id)

    order = Order.new(order_params)
    order.save(validate: false)
    order.order_items.create(menu_item: MenuItem.find(menu_items_params['menu_item_id']), quantity: 1)
  end
end


And(/^"([^"]*)" should( not)? be (?:a|added as a) MenuItem to "([^"]*)"$/) do |child, negative, parent|
  menu = Menu.find_by(title: parent)
  menu_item = MenuItem.find_by(name: child)
  unless negative
    expect(menu.menu_items).to include menu_item
  else
    expect(menu.menu_items).to_not include menu_item
  end

end

Given(/^"([^"]*)" has been added as a MenuItem to "([^"]*)"$/) do |child, parent|
  menu = Menu.find_by(title: parent)
  menu_item = MenuItem.find_by(name: child)
  MenuItemsMenu.create(daily_stock: 10, menu_item: menu_item, menu: menu)
end

