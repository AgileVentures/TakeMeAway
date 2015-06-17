FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'Pa$sw0rd'
    is_admin false
  end
  
  factory :kitchen_user, parent: :user do
    is_admin true
    receive_notifications true
    order_acknowledge_email true
  end

end
