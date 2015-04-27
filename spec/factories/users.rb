FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'Pa$sw0rd'
    is_admin false
  end
end
