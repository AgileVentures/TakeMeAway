Before('@javscript') do
  Capybara.javascript_driver = :poltergeist
end

After('@javascript') do
  Capybara.javascript_driver = :rack_test
end
