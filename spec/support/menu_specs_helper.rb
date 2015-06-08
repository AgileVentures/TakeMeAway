module MenuSpecsHelper
  def daily_stock menu_item
    menu_item.menu_items_menus.find_by(menu_item_id: menu_item.id).daily_stock
  end
end
