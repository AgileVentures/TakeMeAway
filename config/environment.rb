# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer SMTP settings (see config/application.yml for values (file NOT in git))
ActionMailer::Base.smtp_settings = {
  user_name: ENV['SMTP_USERNAME'],
  password:  ENV['SMTP_PASSWORD'],
  domain:    ENV['SMTP_DOMAIN'],
  address:   ENV['SMTP_ADDRESS'],
  port:       587,
  authentication: :plain,
  enable_starttls_auto: true  
}
