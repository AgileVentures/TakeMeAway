# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'admin@tma.org', password: 'password', name: 'Admin', is_admin: true,
receive_notifications: true, order_acknowledge_email: true,
authentication_token: '2-pvxogfa5ah8jtoGb7D')

User.create(email: 'client@tma.org', password: 'password', name: 'Client', is_admin: false)


MenuItem.create(FactoryGirl.attributes_for(:menu_item))
MenuItem.create(FactoryGirl.attributes_for(:menu_item))
order = Order.create(FactoryGirl.attributes_for(:order, user_id: User.last.id))
MenuItem.all.each do |item|
  order.order_items.create(menu_item: item, quantity: 1)
end
