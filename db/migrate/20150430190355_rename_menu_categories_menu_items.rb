class RenameMenuCategoriesMenuItems < ActiveRecord::Migration
  def change
    rename_table :menu_categories_menu_items, :menu_categories_items
  end
end
