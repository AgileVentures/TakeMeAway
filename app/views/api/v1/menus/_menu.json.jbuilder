json.id menu.id
json.title menu.title
json.start_date menu.start_date.strftime('%F')
json.end_date menu.end_date.strftime('%F')
json.uri url_for("#{request.protocol}#{request.host_with_port}#{Rails.application.routes.url_helpers.v1_menu_path(menu.id)}")
json.item_count menu.menu_items_menus.count

if menu.menu_items_menus
  json.items menu.menu_items_menus do |item|
    json.id item.menu_item.id
    json.status item.active? ? 'active' : 'inactive'
    json.name item.menu_item.name
    json.price item.menu_item.price
    json.description item.menu_item.description
    json.ingredients item.menu_item.ingredients
    json.image_thumb cl_image_path item.menu_item.image.path, { width: 100, height: 100, crop: :thumb }
    json.image_medium cl_image_path item.menu_item.image.path, { width: 300, height: 300, crop: :fit }
  end
else
  json.items '"no items"'
end
