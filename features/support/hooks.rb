Before('@javscript') do
  Capybara.javascript_driver = :poltergeist
  page.driver.reset
end

After('@javascript') do
  Capybara.javascript_driver = :rack_test
end
