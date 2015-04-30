require 'rails_helper'

RSpec.describe Menu, :type => :model do
  let(:menu) { FactoryGirl.create(:menu) }

  describe 'Fixtures' do
    it 'should have valid fixture factory' do
      expect(FactoryGirl.create(:menu)).to be_valid
    end
  end

  describe 'Associations' do
  end

  describe 'Database schema' do
    it { is_expected.to have_db_column :show_category }
    it { is_expected.to have_db_column :start_date }
    it { is_expected.to have_db_column :end_date }
    # Timestamps
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }

  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :start_date }
    it { is_expected.to validate_presence_of :end_date }
  end
end
