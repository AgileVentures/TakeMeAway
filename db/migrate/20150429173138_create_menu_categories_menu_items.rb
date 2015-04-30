class CreateMenuCategoriesMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_categories_menu_items, id: false do |t|
      t.belongs_to :menu_category, index: true
      t.belongs_to :menu_item, index: true
    end
  end
end
