FactoryGirl.define do
  factory :order do
    user
    status "MyString"
    order_time Time.now
    pickup_time Time.now + 1.hour
    fulfillment_time Time.now
  end
end
