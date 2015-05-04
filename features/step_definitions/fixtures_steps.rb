Given(/^the following MenuItems exits:$/) do |table|
  table.hashes.each do |hash|
    MenuItem.create!(hash)
  end
end

Given(/^the following Menus exits:$/) do |table|
  table.hashes.each do |hash|
    Menu.create!(hash)
  end
end

Given(/^the following users exist:$/) do |table|
  table.hashes.each do |hash|
    User.create!(hash)
  end
end


And(/^"([^"]*)" should( not)? be (?:an|added as an) MenuItem to "([^"]*)"$/) do |child, negative, parent|
  menu = Menu.find_by(title: parent)
  menu_item = MenuItem.find_by(name: child)
  unless negative
    expect(menu.menu_items).to include menu_item
  else
    expect(menu.menu_items).to_not include menu_item
  end

end

Given(/^"([^"]*)" has been added as an MenuItem to "([^"]*)"$/) do |child, parent|
  #binding.pry
  menu = Menu.find_by(title: parent)
  menu_item = MenuItem.find_by(name: child)
  menu.menu_items << menu_item
end