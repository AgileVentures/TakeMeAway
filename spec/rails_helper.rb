require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
]

SimpleCov.start 'rails'
SimpleCov.start do
  add_filter 'app/admin'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
ActiveRecord::Migration.maintain_test_schema!
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

Capybara.javascript_driver = :webkit

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    begin
      DatabaseCleaner.clean_with(:truncation)
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.before(:each) do
    DatabaseCleaner.strategy = RSpec.current_example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.infer_spec_type_from_file_location!

  config.include Capybara::DSL

  #test helpers
  config.include ResponseJSON
  config.include Authenticate
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# Cloudinary Config for Testing
Cloudinary.config do |config|
  config.cloud_name = 'sample'
  config.api_key = 'test_apikey'
  config.api_secret = 'test_apisecret'
end

