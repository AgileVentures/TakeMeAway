require 'rails_helper'

RSpec.describe MenuCategory, :type => :model do
  context 'is valid when' do
    it 'has required attributes' do
      expect(build(:menu_category, name: 'Lunch')).to be_valid
    end
  end
  context 'is invalid when' do
    if 'has no name' do
      expect(build(:menu_category, name: nil)).to_not be_valid
    end
  end
end
