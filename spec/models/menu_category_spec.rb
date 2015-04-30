require 'rails_helper'

RSpec.describe MenuCategory, :type => :model do

  describe 'Fixtures' do
    it 'should have valid fixture factory' do
      expect(FactoryGirl.create(:menu_category)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many :menu_items }
  end

  describe 'Database schema' do
    it { is_expected.to have_db_column :name }
    #Timestamps
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
  end

end
