FactoryGirl.define do
  factory :order do
    user
    status 'MyString'
    order_time { Time.zone.now }
    pickup_time { Time.zone.now }
    fulfillment_time { Time.zone.now }
  end
end
