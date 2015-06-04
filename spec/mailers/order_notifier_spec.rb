require "rails_helper"

RSpec.describe OrderNotifier, :type => :mailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  
  let(:order) { FactoryGirl.create(:order_with_items) }
  
  describe 'customer' do
    let(:mail) { OrderNotifier.customer(order) }

    it 'should specify delivery to customer email address' do
      expect(mail).to deliver_to(order.user.email)
    end
    
    it 'should specify correct subject' do
      expect(mail).to have_subject('Take-Away Order Receipt Confirmation')
    end
    
    it 'should specify correct from address' do
      expect(mail).to deliver_from('from@example.com')
    end

    it 'should indicate receipt of customer order' do
      expect(mail).to have_body_text('Take-Away Order Receipt')
    end
    
    it 'should contain customer name' do
      expect(mail).to have_body_text(order.user.name)
    end
    
    it 'should have four items in the order' do
      expect(mail).to have_body_text('4 items')
    end

  end

  describe 'kitchen' do
    let(:mail)  { OrderNotifier.kitchen(order) }
    
    it 'should specify delivery to kitchen address' do
      expect(mail).to deliver_to('patmbolger@gmail.com')
    end
    
    it 'should specify correct subject' do
      expect(mail).to have_subject('Order Received')
    end
    
    it 'should specify correct from address' do
      expect(mail).to deliver_from('from@example.com')
    end

    it 'should indicate receipt of customer order' do
      expect(mail).to have_body_text('Order Recieved for Take Me Away')
    end
    
    it 'should contain customer name and email' do
      expect(mail).to have_body_text(order.user.name)
      expect(mail).to have_body_text(order.user.email)
    end
    
    it 'should have multiple items for the order' do
      expect(order.menu_items).not_to be_empty
    end
  end

end
