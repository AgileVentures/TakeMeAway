require 'rails_helper'

RSpec.describe Order, type: :model do
    let!(:user_id) {1}
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

      context 'for :pickup_time' do
        it { is_expected.to allow_value(Time.now + 1.hour).for :pickup_time }
        it { is_expected.not_to allow_value(Faker::Time.between(3.days.ago, 2.days.ago)).for :pickup_time }
      end
    end

end
