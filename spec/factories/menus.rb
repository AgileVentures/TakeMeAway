FactoryGirl.define do
  factory :menu do
    show_category true
    title Faker::Name.name
    start_date { Time.zone.today }
    end_date { Time.zone.today }
  end
end
