class ApplicationMailer < ActionMailer::Base
  default from: ENV['order_receipt_from_email']
  layout 'mailer'
end
