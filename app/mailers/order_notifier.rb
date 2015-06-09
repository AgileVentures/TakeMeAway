class OrderNotifier < ApplicationMailer

  def customer(order)
    @order = order

    mail to: @order.user.email, 
            subject: 'Take-Away Order Receipt Confirmation' do |format|
      format.html
      format.text
    end
  end

  def kitchen(order)
    @order = order
    if Rails.env.test?
      to_email = ENV['order_receipt_from_email']
    else
      to_email = User.notification_email_list || ENV['order_receipt_from_email']
    end
        
    mail to: to_email, subject: 'Order Received' do |format|
      format.html
      format.text
    end
  end
end
