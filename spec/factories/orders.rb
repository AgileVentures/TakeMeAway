FactoryGirl.define do
  factory :order do
    user
    status "MyString"
    order_time Time.now
    pickup_time Time.now
    fulfillment_time Time.now
  end
end
