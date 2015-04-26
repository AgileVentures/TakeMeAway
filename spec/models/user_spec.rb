require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  describe 'Fixtures' do
    it 'should have valid Fixture Factory' do
      expect(FactoryGirl.create(:user)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many :orders }
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
    subject { FactoryGirl.build(:user) }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value('a@a.com', 'a@1b.net').for(:email) }
    it { is_expected.to_not allow_value('a@a', 'a@1b,net', '!d@e.se', 'd@a!.s0').for(:email) }
  end

  describe 'User types' do
    before do
      3.times { FactoryGirl.create(:user) }
      @clients = User.where.not(is_admin: true)
      @admin = FactoryGirl.create(:user, is_admin: true)
    end

    context 'admin?' do
      it { is_expected.to respond_to :admin?}

      it 'returns true if admin' do
        expect(@admin.admin?).to be true
      end

      it 'returns false if not admin' do
        expect(@clients[0].admin?).to be false
      end
    end

    context ':admins scope' do
      it 'returns an array of admins' do
        expect(User.admins).to match_array @admin
      end

      it 'excludes non admins' do
        expect(User.admins).to_not include @clients
      end
    end

    context ':clients scope' do
      it 'returns an array of clients' do
        expect(User.clients).to match_array @clients
      end

      it 'excludes admins' do
        expect(User.clients).to_not include @admin
      end
    end
  end

end
