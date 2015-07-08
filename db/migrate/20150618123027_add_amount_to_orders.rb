class AddAmountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :amount, :decimal
  end
end
