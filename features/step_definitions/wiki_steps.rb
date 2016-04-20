Then(/^the wiki page is seen$/) do
  assert page.current_path == hobbies_path
end

Then(/^the hobby information is seen$/) do
  assert page.current_path == "/hobbies/1"
end

Given(/^the wiki page of the site$/) do

   steps %Q{
      Given the main page of the site
      And I logged in as "user@wiki.edit"
      When I click "Wiki" message button      
  }

end

Then(/^the hobby create page is seen$/) do
    assert page.current_path == new_hobby_path
end

When(/^I click second "(.*?)" message button$/) do |arg1|
    click_link(arg1, :match => :prefer_exact)
end

When(/^I click the first button$/) do

    first(:button).click
end

