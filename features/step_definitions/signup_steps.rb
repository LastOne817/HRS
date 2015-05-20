Given /^the main page of the site$/ do
    visit('/')
end

When(/^I click "(.*?)" message button$/) do |arg1|
    click_link(arg1)
end

Then(/^"(.*?)" page should be opened$/) do |arg1|
  assert page.has_content?("Sign up with Facebook")
end

When(/^I fill E\-mail, Nickname, Password, Password confirm$/) do
  
end

