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

    mail to: User.notification_email_list, subject: 'Order Received' do |format|
      format.html
      format.text
    end
  end
end
