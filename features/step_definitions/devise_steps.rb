def create_admin(params)
  FactoryGirl.create(:user, email: params[:email], password: params[:password], is_admin: true)
end

Given /^I am not (?:signed|logged) in$/ do
  current_driver = Capybara.current_driver
  begin
    Capybara.current_driver = :rack_test
    page.driver.submit :delete, '/admin/logout', {}
  ensure
    Capybara.current_driver = current_driver
  end
end

Given(/^the following users exist:$/) do |table|
  table.hashes.each do |hash|
    User.create!(hash)
  end
end

Given /^I am logged in as admin$/ do
  params = {email: 'example@example.com', password: 'password'}
  create_admin(params)
  step %{I am on the "login" page}
  step %{I fill in "Email" with "#{params[:name]}"}
  step %{I fill in "Password" with "#{params[:password]}"}
  step %{I click "Login" button}
end