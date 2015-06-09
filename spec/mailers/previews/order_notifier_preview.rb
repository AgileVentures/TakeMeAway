class OrderNotifierPreview < ActionMailer::Preview
  def kitchen
    order = FactoryGirl.create(:order_with_items)
    OrderNotifier.kitchen(order)
  end
  
  def customer
    order = FactoryGirl.create(:order_with_items)
    OrderNotifier.customer(order)
  end
end