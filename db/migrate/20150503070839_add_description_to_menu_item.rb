class AddDescriptionToMenuItem < ActiveRecord::Migration
  def change
    add_column :menu_items, :description, :text
  end
end
