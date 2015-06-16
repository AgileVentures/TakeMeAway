class AddMenuIdToOrderItems < ActiveRecord::Migration
  def change
    add_reference :order_items, :menu, index: true, foreign_key: true
  end
end
