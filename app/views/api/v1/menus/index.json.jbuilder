json.date_range Date.today.all_week
json.menus(@menus) do |menu|
  json.partial! 'menu', menu: menu
end


