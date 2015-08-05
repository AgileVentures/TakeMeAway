class MenuItemsController < ApplicationController
  def show
    menu_id = params[:menu_id]
    order_item_id = params[:order_item_id]
    @menu_items = Menu.find(menu_id).menu_items
    render(:partial => 'menu_items', :object => @menu_items, 
            :locals => {order_item_id: order_item_id}) if request.xhr?
  end
end
