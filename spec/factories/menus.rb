FactoryGirl.define do
  factory :menu do
    show_category true
    title { Faker::Name.name }
    start_date { Time.zone.today }
    end_date { Time.zone.today }
  end

  factory :menu_with_item, parent: :menu do
    after(:create) do |menu|
      create_list(:menu_items_menu, 2, menu: menu)
    end
  end
  
  factory :menu_items_menu do
    menu
    menu_item
    daily_stock 10
  end

end
