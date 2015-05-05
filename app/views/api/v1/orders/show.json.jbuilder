json.instance do
  json.user @order.user_id
  json.status @order.status
  json.menu_items do
    @order.menu_items.each do |item|
      json.id item.id
      json.name item.name
      json.price item.price.to_f
    end
  end
end