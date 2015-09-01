class AddDailyStockFieldsToMenuItemsMenu < ActiveRecord::Migration
  def change
    add_column :menu_items_menus, :quantity_sold, :integer
    add_column :menu_items_menus, :quantity_sold_date, :date
  end
end
