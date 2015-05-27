FactoryGirl.define do
  factory :menu_item do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    description { Faker::Lorem.sentence(3) }
    ingredients { Faker::Lorem.sentence(3) }
    image factory: :file
  end
end
