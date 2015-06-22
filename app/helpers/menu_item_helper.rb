module MenuItemHelper
  
  def menu_item_status_color(menu_item)
    case menu_item.status
      when 'active'
        :ok
      when 'inactive'
        :no
    end
  end
  
end
