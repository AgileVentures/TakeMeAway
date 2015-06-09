class OrderNotifierPreview < ActionMailer::Preview
  
  def kitchen
    FactoryGirl.create(:kitchen_user)
    order = FactoryGirl.create(:order_with_items)
    OrderNotifier.kitchen(order)
  end
  def customer
    FactoryGirl.create(:kitchen_user)
    order = FactoryGirl.create(:order_with_items)
    OrderNotifier.customer(order)
  end

end