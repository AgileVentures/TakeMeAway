FactoryGirl.define do
  factory :order do
    user_id 1
    status "MyString"
    order_time Time.now
    pickup_time Time.now
    fulfillment_time Time.now
  end

end
