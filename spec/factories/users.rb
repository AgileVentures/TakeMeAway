FactoryGirl.define do
  factory :user do
    name 'MyString'
    email 'a@example.com'
    password 'Pa$sw0rd'
    is_admin false
  end
end
