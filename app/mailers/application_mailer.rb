class ApplicationMailer < ActionMailer::Base
  default from: User.order_acknowledge_email_address
  layout 'mailer'
end
