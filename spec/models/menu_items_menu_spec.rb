require 'rails_helper'

RSpec.describe MenuItemsMenu, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :menu }
    it { is_expected.to belong_to :menu_item }
  end

  describe 'Database schema' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :menu_id }
    it { is_expected.to have_db_column :menu_item_id }
    it { is_expected.to have_db_column :daily_stock }
    it { is_expected.to have_db_column :quantity_sold }
    it { is_expected.to have_db_column :quantity_sold_date }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :daily_stock }
    it { is_expected.to validate_numericality_of(:daily_stock).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of :menu_item }
  end

  describe 'instance methods' do
    let(:menu) { FactoryGirl.create(:menu) }
    let(:menu_item) { FactoryGirl.create(:menu_item) }

    before(:each) do
      menu.menu_items_menus.create(menu_item: menu_item, daily_stock: 2)
      @menu_item_instance = menu.menu_items_menus.first
      @menu_item_instance.increment_quantity_sold(1)
    end

    describe '#increment_quantity_sold' do
      it 'increases quantity sold today' do
        expect{@menu_item_instance.increment_quantity_sold(1)}.
              to change{@menu_item_instance.quantity_sold}.by(1)
      end
    end

    describe '#decrement_quantity_sold' do
      it 'decreases quantity sold today' do
        expect{@menu_item_instance.decrement_quantity_sold(1)}.
              to change{@menu_item_instance.quantity_sold}.by(-1)
      end
    end

    describe '#active?' do
      it 'returns true if qty sold < daily_stock' do
        expect(@menu_item_instance.active?).to be_truthy
      end

      it 'returns false if qty sold >= daily_stock' do
        @menu_item_instance.increment_quantity_sold(1)
        expect(@menu_item_instance.quantity_sold).to eq @menu_item_instance.daily_stock
        expect(@menu_item_instance.active?).to_not be_truthy
      end
      it 'sets inactive item to active on next day' do
        @menu_item_instance.increment_quantity_sold(1)
        expect(@menu_item_instance.active?).to_not be_truthy
        Timecop.freeze(Time.zone.tomorrow)
        expect(@menu_item_instance.active?).to be_truthy
        Timecop.return
      end
    end
  end
end
