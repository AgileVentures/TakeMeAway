json.cache! menu do
  json.menu do
    json.id menu.id
    json.title menu.title
    json.start_date menu.start_date.strftime('%F')
    json.end_date menu.end_date.strftime('%F')
  end
  json.uri url_for("#{request.protocol}#{request.host_with_port}#{Rails.application.routes.url_helpers.v1_menu_path(menu.id)}")
  json.item_count menu.menu_items.count


  if menu.menu_items
    json.items menu.menu_items do |item|
      json.item item.name
      json.price item.price
      json.description item.description
      json.ingredients item.ingredients
    end
  else
    json.items '"no items"'
  end


end
