class AddIngredientsToMenuItems < ActiveRecord::Migration
  def change
    add_column :menu_items, :ingredients, :string
  end
end
