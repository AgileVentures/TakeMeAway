FactoryGirl.define do
  factory :menu do
    show_category true
    title Faker::Name.name
    start_date Date.today
    end_date Date.today
  end
end
