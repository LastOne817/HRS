Then(/^I should see Profile page$/) do
  assert page.current_path == pages_profile_path
end

Then(/^I should see my name "(.*?)"$/) do |arg1|
  assert page.has_content?(arg1)
end

