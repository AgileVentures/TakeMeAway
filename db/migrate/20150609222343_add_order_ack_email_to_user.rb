class AddOrderAckEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :order_acknowledge_email, :boolean, default: false
  end
end
