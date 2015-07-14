require 'rails_helper'

RSpec.describe MenuItem, type: :model do
    let(:menu_item) { FactoryGirl.create(:menu_item) }

    describe 'Fixtures' do
      it 'should have valid fixture factory' do
        expect(FactoryGirl.create(:menu_item)).to be_valid
      end
    end

    describe 'Associations' do
      it { is_expected.to have_many :order_items }
      it { is_expected.to have_many(:orders).through :order_items }
      it { is_expected.to have_many :menu_items_menus }
      it { is_expected.to have_many(:menus).through :menu_items_menus }
      it { is_expected.to have_and_belong_to_many :menu_categories }
      it { is_expected.to have_many :image_files }
    end

    describe 'Database schema' do
      it { is_expected.to have_db_column :name }
      it { is_expected.to have_db_column :price }
      it { is_expected.to have_db_column :description }
      it { is_expected.to have_db_column :ingredients }
      it { is_expected.to have_db_column :status }
      # Timestamps
      it { is_expected.to have_db_column :created_at }
      it { is_expected.to have_db_column :updated_at }
    end

    describe 'Validations' do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_presence_of :price }
      it { is_expected.to validate_presence_of :status }
      it { is_expected.to validate_inclusion_of(:status).
                          in_array(MenuItem::STATUS) }
    end
    
    describe 'validate menu_item destroy' do
      before(:each) do
        Timecop.freeze(Time.zone.now.at_beginning_of_week)
        @old_menu = FactoryGirl.create(:menu_with_item, start_date: 2.weeks.ago.to_date, 
                                        end_date: 1.week.ago.to_date)
        @current_menu = FactoryGirl.create(:menu_with_item, start_date: Date.today, 
                                        end_date: 1.week.from_now)
        @future_menu = FactoryGirl.create(:menu_with_item, start_date: 1.week.from_now, 
                                        end_date: 2.weeks.from_now)
                                        
        @menu_item = FactoryGirl.create(:menu_item)
                                        
        @processed_order = FactoryGirl.create(:order_with_items, status: 'processed')
        @pending_order   = FactoryGirl.create(:order_with_items, status: 'pending')
        @canceled_order  = FactoryGirl.create(:order_with_items, status: 'canceled')
      end
                
      it 'can be destroyed if not in current menu' do
        expect(@old_menu.menu_items[0].can_menu_item_be_destroyed?).to be true
      end
      it 'can NOT be destroyed if in current menu' do
        expect(@current_menu.menu_items[0].can_menu_item_be_destroyed?).to be false
      end
      it 'can NOT be destroyed if in future menu' do
        expect(@future_menu.menu_items[0].can_menu_item_be_destroyed?).to be false
      end
      it 'can be destroyed if not in any order' do
        expect(@menu_item.can_menu_item_be_destroyed?).to be true
      end
      it 'can NOT be destroyed if in canceled order' do
        expect(@canceled_order.menu_items[0].can_menu_item_be_destroyed?).to be false
      end
      it 'can NOT be destroyed if in processed order' do
        expect(@processed_order.menu_items[0].can_menu_item_be_destroyed?).to be false
      end
      it 'can NOT be destroyed if in pending order' do
        expect(@pending_order.menu_items[0].can_menu_item_be_destroyed?).to be false
      end
    end

end
