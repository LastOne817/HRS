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
    fill_in('signup_email', :with => "test@bdd.cucumber")
    fill_in('signup_username', :with => "behavior")
    fill_in('signup_password', :with => "cucumberbdd")
    fill_in('signup_password_confirmation', :with => "cucumberbdd")
    click_button('signup_submit_button') 
end

