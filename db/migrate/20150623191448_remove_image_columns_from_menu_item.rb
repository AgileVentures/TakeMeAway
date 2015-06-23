class RemoveImageColumnsFromMenuItem < ActiveRecord::Migration
  def change
    remove_column :menu_items, :image_file_name, :string
    remove_column :menu_items, :image_content_type, :string
    remove_column :menu_items, :image_file_size, :integer
    remove_column :menu_items, :image_updated_at, :datetime
  end
end
