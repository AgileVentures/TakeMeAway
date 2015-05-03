FactoryGirl.define do
  factory :menu do
    show_category true
    title Faker::Name.name
    start_date "2015-04-28 20:07:53"
    end_date "2015-04-28 20:07:53"
  end
end
