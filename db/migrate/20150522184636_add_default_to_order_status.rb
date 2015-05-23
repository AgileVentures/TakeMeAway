class AddDefaultToOrderStatus < ActiveRecord::Migration
  def change
    change_column :orders, :status, :string, default: 'pending', null: false
  end
end
