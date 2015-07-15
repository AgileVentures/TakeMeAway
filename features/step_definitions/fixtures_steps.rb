Given(/^the following MenuItems exist:$/) do |table|
  table.hashes.each do |hash|
    MenuItem.create!(hash)
  end
end

Given(/^the following Menus exist:$/) do |table|
  table.hashes.each do |hash|
    hash['end_date'] = Date.today if hash['end_date'].empty?
    hash['start_date'] = 1.week.from_now  if hash['start_date'] == 'future'
    hash['end_date']   = 2.weeks.from_now if hash['end_date']   == 'future'
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
    menu_items_params = params['menu_item']
    menu_params = params['menu']
    user = User.find_by(name: user_params['user'])
    order_params.merge!('user_id' => user.id)

    order = Order.new(order_params)
    order.save(validate: false)
    order.order_items.create(menu_item: MenuItem.find_by_name(menu_items_params['name']),
            menu: Menu.find(menu_params['id']), quantity: 1)
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

And(/^"([^"]*)" has been added to order (\d+) from Menu "([^"]*)"$/) do |item, order, menu|
  Order.find(order).order_items.create(menu_item: MenuItem.find_by_name(item),
          menu: Menu.find_by_title(menu))
end

