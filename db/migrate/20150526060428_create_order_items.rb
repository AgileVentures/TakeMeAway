class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :menu_item, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.integer :quantity
    end
  end
end
