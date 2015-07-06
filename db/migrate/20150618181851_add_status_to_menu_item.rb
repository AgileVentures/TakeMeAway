class AddStatusToMenuItem < ActiveRecord::Migration
  def change
    add_column :menu_items, :status, :string, default: 'active'
  end
end
