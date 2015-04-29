class CreateMenuCategories < ActiveRecord::Migration
  def change
    create_table :menu_categories do |t|
      t.string :name, limit: 45
      t.timestamps null: false
    end
  end
end
