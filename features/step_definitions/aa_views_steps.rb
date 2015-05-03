Then(/^I should see an index of "([^"]*)"$/) do |arg|
  expect(page).to have_selector("table#index_table_#{arg.downcase}")
end


And(/^I should see ([^"]*) record rows$/) do |count|
  within 'tbody' do
    expect(page).to have_selector('tr', count: count.to_i)
  end
end