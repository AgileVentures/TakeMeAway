class OrderNotifier < ApplicationMailer

  def customer(order)
    @order = order

    mail to: order.user.email, subject: 'Take-Away Order Receipt Confirmation' do |format|
      format.html
      format.text
    end
  end

  def kitchen(order)
    @order = order
    
    # CHANGE 'TO' ADDRESS TO PRODUCTION SETTING
    mail to: 'patmbolger@gmail.com', subject: 'Order Received' do |format|
      format.html
      format.text
    end
  end
end
