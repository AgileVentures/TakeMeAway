Before('@javascript') do
  Capybara.current_driver = :poltergeist
end

After('@javascript') do
  Capybara.reset_sessions!
  Capybara.current_driver = :rack_test
end

Before('@cloudinary') do
  Cloudinary.config do |config|
    config.cloud_name = 'sample'
    config.api_key = 'test_apikey'
    config.api_secret = 'test_apisecret'
  end

  stub_request(:post, "https://api.cloudinary.com/v1_1/sample/auto/upload").
    to_return(status: 200, body: {
      public_id: "publicid_1",
      version: 11,
      width: 640,
      height: 643,
      format:"jpg",
      resource_type: "image"
    }.to_json)

  stub_request(:post, "https://api.cloudinary.com/v1_1/sample/image/tags").
    to_return(status: 200, body: {}.to_json)
end
