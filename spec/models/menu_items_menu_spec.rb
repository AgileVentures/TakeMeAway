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
end
