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
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :daily_stock }
    it { is_expected.to validate_numericality_of :daily_stock }
    it { is_expected.to validate_presence_of :menu }
    it { is_expected.to validate_presence_of :menu_item }
  end

  describe 'instance methods' do
    let(:menu) { FactoryGirl.create(:menu) }
    let(:menu_item) { FactoryGirl.create(:menu_item) }
    before(:each) do

      menu.menu_items_menus.create(menu_item: menu_item, daily_stock: 20)
      @menu_item_instance = menu.menu_items_menus.first
    end
    describe '#decrement_stock' do
      it 'reduces daily stock' do
        expect{@menu_item_instance.decrement_stock(1)}.to change{@menu_item_instance.daily_stock}.from(20).to(19)
      end
    end

    describe '#increment_stock' do
      it 'increases daily stock' do
        expect{@menu_item_instance.increment_stock(1)}.to change{@menu_item_instance.daily_stock}.by(1)
      end
    end
  end
end
