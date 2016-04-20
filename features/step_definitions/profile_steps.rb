Then(/^I should see Profile page$/) do
  assert page.current_path == pages_profile_path
end

Then(/^I should see my name "(.*?)"$/) do |arg1|
  assert page.has_content?(arg1)
end

Given(/^the profile page of the site with logged in$/) do
  steps %Q{
     Given the main page of the site
     And I logged in as "user@cucumber.profile"
     When I click "Edit Profile" message button
     Then I should see Profile page
     And I should see my name "thisisBDD"
}
end

When(/^I fill current password and new password and new password confirm$/) do
    fill_in('change_password_current_password', :with => "cucumberbdd")
    fill_in('change_password_new_password', :with => "newpassword")
    fill_in('change_password_password_confirm', :with => "newpassword")
end

When(/^I upload a photo$/) do
  attach_file(:photo, File.join(Rails.root, 'features', 'upload-files', 'Penguins.jpg'))
end


