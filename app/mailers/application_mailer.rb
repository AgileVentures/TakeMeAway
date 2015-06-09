class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"  # CHANGE TO PRODUCTION SETTING
  layout 'mailer'
end
