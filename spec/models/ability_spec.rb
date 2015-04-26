require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  describe 'Abilities' do
    let(:admin) { FactoryGirl.create(:user, is_admin: true) }
    let(:user) { FactoryGirl.create(:user, is_admin: false) }
    let(:ability) { FactoryGirl.create(:user, is_admin: true) }

    context 'Admin' do
      subject(:ability) { Ability.new(admin) }
      it { is_expected.to be_able_to :manage, user }
      it { is_expected.to be_able_to :manage, MenuItem.new }
      it { is_expected.to be_able_to :manage, Order.new }

    end

    context 'Client' do
      subject(:ability) { Ability.new(user) }
      it { is_expected.to_not be_able_to :manage, user }
      it { is_expected.to_not be_able_to :manage, MenuItem.new }
      it { is_expected.to_not be_able_to :manage, Order.new }
      it { is_expected.to be_able_to :create, Order.new }

    end
  end
end