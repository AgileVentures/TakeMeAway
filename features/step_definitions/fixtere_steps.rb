Given(/^the following MenuItems exits:$/) do |table|
  table.hashes.each do |hash|
    MenuItem.create!(hash)
  end
end

Given(/^the following users exist:$/) do |table|
  table.hashes.each do |hash|
    User.create!(hash)
  end
end