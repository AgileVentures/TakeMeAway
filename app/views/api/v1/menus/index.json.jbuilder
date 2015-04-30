
  json.menus(@menus)do |menu|
    json.partial! 'menu', menu: menu
  end


