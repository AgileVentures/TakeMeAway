class CreateMenuItemsMenus < ActiveRecord::Migration
  def change
    create_table :menu_items_menus, id: false do |t|
      t.belongs_to :menu, index: true
      t.belongs_to :menu_item, index: true
    end

    add_index :menu_items_menus, [:menu_id, :menu_item_id], unique: true
  end
end
