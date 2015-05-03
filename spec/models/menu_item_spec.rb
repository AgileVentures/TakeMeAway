require 'rails_helper'

RSpec.describe MenuItem, type: :model do
    let(:menu_item) { FactoryGirl.create(:menu_item) }

    describe 'Fixtures' do
      it 'should have valid fixture factory' do
        expect(FactoryGirl.create(:menu_item)).to be_valid
      end
    end

    describe 'Associations' do
      # it { is_expected.to have_one :image}
      it { is_expected.to have_and_belong_to_many :orders }
      it { is_expected.to have_and_belong_to_many :menus }
      it { is_expected.to have_and_belong_to_many :menu_categories }
    end

    describe 'Database schema' do
      it { is_expected.to have_db_column :name }
      it { is_expected.to have_db_column :price }
      it { is_expected.to have_db_column :description }
      # Timestamps
      it { is_expected.to have_db_column :created_at }
      it { is_expected.to have_db_column :updated_at }

    end

    describe 'Validations' do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_presence_of :price }
    end

end
