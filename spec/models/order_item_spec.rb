require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :order }
    it { is_expected.to belong_to :menu_item }
  end

  describe 'Database schema' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :order_id }
    it { is_expected.to have_db_column :menu_item_id }
    it { is_expected.to have_db_column :quantity }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :quantity }
    it { is_expected.to validate_numericality_of :quantity }
    it { is_expected.to validate_presence_of :order }
    it { is_expected.to validate_presence_of :menu_item }
  end


end
