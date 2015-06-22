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

end
