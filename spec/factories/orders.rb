FactoryGirl.define do
  factory :order do
    user
    status 'MyString'
    order_time { Time.zone.now }
    pickup_time { Time.zone.now + 1.hour }
    fulfillment_time { Time.zone.now }
  end
end
