class DropMenuItemsOrders < ActiveRecord::Migration
  def change
    drop_table :menu_items_orders
  end
end
