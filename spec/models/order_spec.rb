require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:user_id) { 1 }
  let(:order) { FactoryGirl.create(:order) }

  describe 'Fixtures' do
    it 'should have valid fixture factory' do
      expect(FactoryGirl.create(:order)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many :menu_items }
    it { is_expected.to belong_to :user }
  end

  describe 'Database schema' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :status }
    it { is_expected.to have_db_column :order_time }
    it { is_expected.to have_db_column :pickup_time }
    it { is_expected.to have_db_column :fulfillment_time }
    #Timestamps
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }

  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :user }

    context 'for :status' do
      it { is_expected.to validate_inclusion_of(:status).in_array Order::STATUS }
      it { is_expected.not_to allow_value('whatever').for :status }
    end

    context 'for :pickup_time' do
      it { is_expected.to allow_value(Time.now + 1.hour).for :pickup_time }
      it { is_expected.not_to allow_value(Faker::Time.between(3.days.ago, 2.days.ago)).for :pickup_time }
    end
  end

  describe 'class methods' do
    context '#total' do
      let(:menu_item1) { FactoryGirl.create(:menu_item, price: 50) }
      let(:menu_item2) { FactoryGirl.create(:menu_item, price: 60) }

      before(:each) do
        m_items = [menu_item1, menu_item2]
        m_items.each do |item|
          order.menu_items << item
          order.save!
        end
      end

      it '#total returns sum of all menu_items if present' do
        expect(order.total).to eq 110
      end

      it '#total returns nil if no menu_items present' do
        new_order = FactoryGirl.create(:order)
        expect(new_order.total).to eq nil
      end

    end

  end

  describe 'scopes' do
    let(:order) { FactoryGirl.create(:order) }
    let(:order2) { FactoryGirl.create(:order) }

    describe '#canceled' do
      it 'returns orders with status \'canceled\'' do
        order.update_attribute(:status, 'canceled')
        expect(Order.canceled).to include order
      end

      it 'excludes orders with status other then \'canceled\'' do
        order2.update_attribute(:status, 'pending')
        expect(Order.canceled).to_not include order2
      end
    end

    describe '#pending' do
      it 'returns orders with status \'pending\'' do
        order.update_attribute(:status, 'pending')
        expect(Order.pending).to include order
      end

      it 'excludes orders with status other then \'pending\'' do
        order2.update_attribute(:status, 'processed')
        expect(Order.pending).to_not include order2
        order2.update_attribute(:status, 'canceled')
        expect(Order.pending).to_not include order2
      end
    end

    describe '#processed' do
      it 'returns orders with status \'processed\'' do
        order.update_attribute(:status, 'processed')
        expect(Order.processed).to include order
      end

      it 'excludes orders with status other then \'processed\'' do
        order2.update_attribute(:status, 'pending')
        expect(Order.processed).to_not include order2
        order2.update_attribute(:status, 'canceled')
        expect(Order.processed).to_not include order2
      end
    end
  end

end
