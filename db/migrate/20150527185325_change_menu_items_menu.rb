class ChangeMenuItemsMenu < ActiveRecord::Migration
  def change
    drop_table :menu_items_menus
    create_table :menu_items_menus do |t|
      t.references :menu_item, index: true, foreign_key: true
      t.references :menu, index: true, foreign_key: true
      t.integer :daily_stock
    end
  end
end
