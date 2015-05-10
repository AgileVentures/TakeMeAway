json.instance do
  json.user order.user_id
  json.status order.status
  json.pickup_time order.pickup_time

  if order.menu_items
    json.items order.menu_items do |item|
      json.id item.id
      json.item item.name
      json.price item.price.to_f
    end
  else
    json.items '"no items"'
  end

end