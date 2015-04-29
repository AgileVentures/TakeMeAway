shared_examples 'token_authenticatable' do
  let(:item) { FactoryGirl.create(class_symbol) }
  before { @class_symbol = described_class.name.underscore }

  describe '#ensure_authentication_token' do
    it 'creates auth token' do
      item = FactoryGirl.create(@class_symbol, authentication_token: '')
      expect(item.authentication_token).not_to be_blank
    end
  end

  describe '#reset_authentication_token!' do
    it 'resets auth token' do
      #pending
    end
  end

  describe 'find_by(authentication_token: )' do
    context 'with valid token' do
      it 'finds correct user' do
        item = FactoryGirl.create(@class_symbol)
        item_found = described_class.find_by(authentication_token: item.authentication_token)
        expect(item_found).to eq item
      end
    end

    context 'with nil token' do
      it 'returns nil' do
        item_found = described_class.find_by(authentication_token: nil)
        expect(item_found).to be_nil
      end
    end
  end

end