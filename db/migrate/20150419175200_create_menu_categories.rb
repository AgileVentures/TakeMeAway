class CreateMenuCategories < ActiveRecord::Migration
  def change
    create_table :menu_categories do |t|
      t.string :name, limit: 45
      t.references :menu, index: true, foreign_key: true
      t.references :menu_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
