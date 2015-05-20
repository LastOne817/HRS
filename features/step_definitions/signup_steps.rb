Given /^the main page of the site$/ do
    visit('/')
end

When(/^I click "(.*?)" message button$/) do |arg1|
    click_link(arg1)
end

Then(/^"signup" page should be opened$/) do
 #   assert page.has_content?("Sign up with Facebook")
    assert page.current_path == pages_signup_path
end

When(/^I fill E\-mail, Nickname, Password, Password confirm$/) do
    fill_in('signup_email', :with => "test@bdd.cucumber")
    fill_in('signup_username', :with => "behavior")
    fill_in('signup_password', :with => "cucumberbdd")
    fill_in('signup_password_confirmation', :with => "cucumberbdd")
end

When(/^I press "(.*?)" button$/) do |arg1|
    click_button(arg1)
end

Then(/^the main page should be seen and I should see welcoming message$/) do
   assert page.current_path == pages_main_path
end

When(/^I fill E\-mail, Nickname, Password, Password confirm uncorrectly$/) do
   fill_in('signup_email', :with => "test@bdd.cucumber")
   fill_in('signup_username', :with => "behavior")
   fill_in('signup_password', :with => "cucumberbdd")
   fill_in('signup_password_confirmation', :with => "cucumberbdd202")
end

Then(/^the failure message given$/) do
   assert page.has_content?("Password Confirm is incorrect")
end

