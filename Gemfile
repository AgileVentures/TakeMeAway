source "https://rubygems.org"

ruby "2.2.1"

gem "bourbon", "~> 4.2.0"
gem "coffee-rails", "~> 4.1.0"
# gem "delayed_job_active_record"
gem "email_validator"
gem "flutie"
# gem "high_voltage"
gem "i18n-tasks"
gem "jquery-rails"
gem "neat", "~> 1.7.0"
gem "newrelic_rpm", ">= 3.9.8"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "rails", "4.2.1"
gem "recipient_interceptor"
gem "refills"
gem "sass-rails", "~> 5.0"
# gem "simple_form"
gem "title"
gem "uglifier"
gem "unicorn"
gem 'devise'
gem 'activeadmin', github: 'activeadmin'
gem 'active_skin'
gem 'cancancan', '~> 1.10.1'
gem 'active_admin_datetimepicker'
gem 'rack-cors', :require => 'rack/cors'
gem 'date_validator'
gem 'jbuilder'
gem 'paperclip'
gem 'paperclip_database'

group :development do
  # gem "spring"
  # gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bundler-audit", require: false
  gem "pry-byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "rspec-rails", "~> 3.1.0"
  gem 'timecop'
  gem 'faker'
  gem 'jc-validates_timeliness' #Date and time validation plugin for ActiveModel and Rails
  gem 'poltergeist' # Headless javascript driver
  gem 'selenium-webdriver' # javascript driver used for debugging
end

group :test do
  gem "capybara-webkit", ">= 1.2.0"
  gem "cucumber-rails", :require => false # Cucmber features
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers', require: false
  gem "webmock"
  gem "capybara"
  gem 'coveralls', '~> 0.7.9', require: false
end

group :staging, :production do
  gem 'rails_12factor'
  gem "rack-timeout"
end

group :development, :staging, :production do
  gem "rack-timeout"
end

