# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Set ActionMailer to use Sendgrid - CHANGE TO PRODUCTION SETTINGS UPON DEPLOYMENT
ActionMailer::Base.smtp_settings = {
  user_name: 'patmbolger',
  password:  '38LjEPStn-',
  domain:    'herokuapp.com',
  address:   'smtp.sendgrid.net',
  port:       587,
  authentication: :plain,
  enable_starttls_auto: true  
}
