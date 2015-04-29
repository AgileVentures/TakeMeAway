json.cache! menu do
  json.menu do
    json.start_date menu.start_date.strftime('%F')
    json.end_date menu.end_date.strftime('%F')
  end
  json.specials do
    json.items "no items"
  end


end
