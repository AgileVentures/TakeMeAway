def path_to(page_name, id = '')
  name = page_name.downcase
  case name
    when 'home' then
      root_path
    when 'login' then
      new_user_session_path
    else
      raise('path to specified is not listed in #path_to')
  end
end


Then /^I should be on the "([^"]*)" page$/ do |page|
  expect(current_path).to eq path_to(page)
end
