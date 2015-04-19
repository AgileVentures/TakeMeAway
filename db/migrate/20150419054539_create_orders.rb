class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :status
      t.datetime :order_time
      t.datetime :pickup_time
      t.datetime :fulfillment_time

      t.timestamps null: false
    end
  end
end
