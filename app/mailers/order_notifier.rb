class OrderNotifier < ApplicationMailer

  def customer  # needs method to be edited - this is the code created by the generator
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def kitchen(order)
    @order = order
    
    mail to: @order.user.email, subject: 'Order Receipt Confirmation'
  end
end
