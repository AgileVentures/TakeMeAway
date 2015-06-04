FactoryGirl.define do
  factory :order do
    user
    status 'pending'
    order_time { Time.zone.now }
    pickup_time { Time.zone.now + 1.hour }
    fulfillment_time { Time.zone.now }
  end

  factory :order_with_items, parent: :order do
    after(:create) do |order|
      create_list(:order_item, 4, order: order)
    end
  end

  factory :order_item do
    order
    menu_item
    quantity 1
  end
  
end
