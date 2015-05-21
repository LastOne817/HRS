require 'digest'

Given(/^I signed up as "(.*?)" and "(.*?)" and "(.*?)"$/) do |email, username, password|
    user = User.new({salt: "12345678",email: email, username: username, password: Digest::SHA256.hexdigest("12345678" + password)})
    user.save
end

Then(/^I "login" page should be opened$/) do
  assert page.current_path == pages_login_path
end

When(/^I fill E\-mail and password as "(.*?)" and "(.*?)" in login page$/) do |email, password|
    fill_in('login_email', :with => email)
    fill_in('login_password', :with => password)
end

Given(/^I logged in as "(.*?)"$/) do |email|

steps %Q{
     Given the main page of the site
     And I signed up as "#{email}" and "thisisBDD" and "cucumberbdd"
     When I click "Log in" message button
     Then I "login" page should be opened
     When I fill E-mail and password as "#{email}" and "cucumberbdd" in login page
     And I press "login_submit_button" button
     Then the main page should be seen and I should see welcoming message
  }
end

Then(/^the main page should be seen and I should see log out message$/) do
  assert page.has_content?("logged out successfully")
end

