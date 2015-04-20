require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Fixtures' do
    it 'should have valid Fixture Factory' do
      expect(FactoryGirl.create(:user)).to be_valid
    end
  end

  describe 'Database Schema' do
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :is_admin }
    # Timestamps
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of :email }
  end
end
