json.id order.id
json.user order.user_id
json.status order.status
json.pickup_time clean_time(order.pickup_time)
json.amount order.amount

if order.order_items
  json.items order.order_items do |item|
    json.id item.menu_item.id
    json.item item.menu_item.name
    json.price item.menu_item.price.to_f
  end
else
  json.items '"no items"'
end

