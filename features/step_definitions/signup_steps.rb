Given /^the main page of the site$/ do
    visit('/')
end

When /^I click "(\w+)" message button$/ do |button|
    click_link(button)
end

When(/^I click "(.*?)" message button$/) do |arg1|
    click_link(arg1)
end

