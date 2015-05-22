require 'rails_helper'

describe OrdersHelper, type: :helper do

  describe 'status_color' do
    before(:each) do
      subject = Order.new
    end

    it 'returns :warn class on pending' do
      allow(subject).to receive(:status).and_return 'pending'
      expect(status_color(subject)).to eq :warn
    end

    it 'returns :ok class on processed' do
      allow(subject).to receive(:status).and_return 'processed'
      expect(status_color(subject)).to eq :ok
    end

    it 'returns :no class on canceled' do
      allow(subject).to receive(:status).and_return 'canceled'
      expect(status_color(subject)).to eq :no
    end

  end

end