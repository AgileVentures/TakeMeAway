class CreateMenuCategoriesMenus < ActiveRecord::Migration
  def change
    create_table :menu_categories_menus, id: false do |t|
      t.belongs_to :menu_category, index: true
      t.belongs_to :menu, index: true
    end
  end
end
