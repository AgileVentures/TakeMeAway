require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:menu) { FactoryGirl.create(:menu) }

  describe 'Fixtures' do
    it 'should have valid fixture factory' do
      expect(FactoryGirl.create(:menu)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many :menu_items_menus }
    it { is_expected.to have_many(:menu_items).through :menu_items_menus }

    it 'join table should have unique index' do
      ActiveRecord::Migration.index_exists?(:menu_items_menus, [:menu_id, :menu_item_id], unique: true)
    end
    it { should accept_nested_attributes_for(:menu_items_menus) }
  end

  describe 'Database schema' do
    it { is_expected.to have_db_column :show_category }
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column(:start_date).of_type(:date) }
    it { is_expected.to have_db_column(:end_date).of_type(:date) }
    # Timestamps
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :start_date }
    it { is_expected.to validate_presence_of :end_date }
    it 'invalidates end_date earlier than start_date' do
      expect(FactoryGirl.build(:menu, start_date: Date.today, 
                               end_date: Date.yesterday)).to_not be_valid
    end
    it 'invalidates same menu_item included in overlapping menus' do
      item = FactoryGirl.create(:menu_item)
      menu1 = FactoryGirl.build(:menu, start_date: Date.today, end_date: Date.tomorrow)
      menu1.menu_items_menus << FactoryGirl.build(:menu_items_menu, 
                                  menu_item: item, daily_stock: 1)
      menu1.save!
      expect(menu1).to be_valid
      menu2 = FactoryGirl.build(:menu, start_date: Date.today, end_date: Date.tomorrow)
      menu2.menu_items_menus << FactoryGirl.build(:menu_items_menu, 
                                  menu_item_id: item.id, daily_stock: 1)
      expect(menu2).to_not be_valid
    end
  end

  describe 'Class methods' do
    before(:each) do
      Timecop.freeze(Time.zone.now.at_beginning_of_week)
      @menu1 = FactoryGirl.create(:menu, start_date: 1.week.ago.to_date,
                                         end_date: 1.week.ago.end_of_week.to_date)
      @menu2 = FactoryGirl.create(:menu, start_date: 2.weeks.ago.to_date,
                                         end_date: 1.week.ago.to_date)
      @menu3 = FactoryGirl.create(:menu, start_date: Date.today, 
                                         end_date: Date.today)
      @menu4 = FactoryGirl.create(:menu, start_date: 2.days.from_now, 
                                         end_date: 3.days.from_now)
      @menu5 = FactoryGirl.create(:menu, start_date: 1.week.from_now,
                                         end_date: 1.week.from_now.end_of_week.to_date)
      @menu6 = FactoryGirl.create(:menu, start_date: 1.day.from_now, 
                                         end_date: 1.week.from_now)
      @menu6.menu_items_menus << FactoryGirl.create(:menu_items_menu, menu: @menu6)
      @menu6.menu_items_menus << FactoryGirl.create(:menu_items_menu, menu: @menu6)
      
      @menu_item1 = FactoryGirl.create(:menu_item)
      @menu7 = FactoryGirl.create(:menu, start_date: Date.today, 
                                         end_date: 1.week.from_now)
      @menu7.menu_items_menus << 
        MenuItemsMenu.create(menu_item_id: @menu6.menu_items_menus[0].menu_item_id,
                             daily_stock: @menu6.menu_items_menus[0].daily_stock) 
                             
      @menu8 = FactoryGirl.create(:menu, start_date: 1.day.from_now, 
                                         end_date: 1.week.from_now)
      @menu8.menu_items_menus << FactoryGirl.create(:menu_items_menu, menu: @menu8)
    end

    after(:each) do
      Timecop.return
    end

    it 'includes current weeks menus on #this_week' do
      expect(Menu.this_week).to include @menu3, @menu4, @menu6
    end

    it 'excludes other weeks menus on #this_week' do
      expect(Menu.this_week).to_not include @menu1, @menu2, @menu5
    end

    it 'identifies menu_item as included in menu(s)' do
      expect(Menu.item_in_menu?(@menu6.menu_items[0])).to be true
    end

    it 'identifies menu_item as not included in menu(s)' do
      expect(Menu.item_in_menu?(@menu_item1)).to be false
    end
    
    it 'destroys associated menu_items_menu records on menu delete' do
      expect{ @menu6.destroy }.to change(MenuItemsMenu, :count).by(-2)
    end
    
    context 'Checking menu_item overlap in other menu' do
      it 'confirms menu_item is in an overlapping menu' do
        expect(@menu7.menu_items_menus[0].overlapping_menu).to_not be nil
      end
      
      it 'confirms menu_item is NOT in an overlapping menu' do
        expect(@menu8.menu_items_menus[0].overlapping_menu).to be nil
      end
    end
    
    context 'Checking scopes' do
      it '#this_week includes correct menus for this week' do
        expect(Menu.this_week).to include @menu3, @menu4, @menu6, @menu7, @menu8
      end
      it '#this_week excludes menus not active this week' do
        expect(Menu.this_week).to_not include @menu1, @menu2, @menu5
      end
      it '#today includes menus active today' do
        expect(Menu.today).to include @menu3, @menu7
      end
      it '#today excludes menus not active today' do
        expect(Menu.today).to_not include @menu1, @menu2, @menu4, @menu5, @menu6, @menu8
      end
    end
  end
end
