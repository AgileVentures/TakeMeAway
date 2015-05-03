Then(/^I should see an index of "([^"]*)"$/) do |arg|
  expect(page).to have_selector("table#index_table_#{arg.downcase}")
end


And(/^I should see ([^"]*) record (?:row|rows$)/) do |count|
  within 'tbody' do
    expect(page).to have_selector('tr', count: count.to_i)
  end
end

When(/^I click the "([^"]*)" link for "([^"]*)"$/) do |link, item|
  page.all('table tr').each do |tr|
    next unless tr.has_text?(item)

    # Do stuff with trs that meet the href requirement
    #puts tr.text
    within(tr) do
      click_link link.humanize
    end
  end
end