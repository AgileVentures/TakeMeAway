class DestroyMenuCategoriesMenus < ActiveRecord::Migration
  def change
    drop_table :menu_categories_menus
  end
end
