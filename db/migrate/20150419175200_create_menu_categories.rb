class CreateMenuCategories < ActiveRecord::Migration
  def change
    create_table :menu_categories do |t|
      t.string :name, limit: 45
      t.timestamps null: false
    end
    
    create_table :menu_categories_menu_items, id: false do |t|
      t.belongs_to :menu_category, index: true
      t.belongs_to :menu_item, index: true
    end
    
    create_table :menu_categories_menus, id: false do |t|
      t.belongs_to :menu_category, index: true
      t.belongs_to :menu, index: true
    end
  end
end
