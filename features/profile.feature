Feature: Edit Profile

Scenario: User Profile - information given

Given the main page of the site
And I logged in as "user@cucumber.profile"
When I click "Edit Profile" message button
Then I should see Profile page
And I should see my name "thisisBDD"

Scenario: User Profile - Change password

Given the profile page of the site with logged in
When I press "profile_change_password" button
And I fill current password and new password and new password confirm
And I press "change_password_submit_button" button
Then the main page should be seen
And I should see the message "Password has changed sucessfully"

Scenario: Edit Profile - Delete User

Given the profile page of the site with logged in
When I press "profile_delete_user" button
And I press "delete_user_submit_button" button
Then the main page should be seen
And I should see the message "your account is deleted successfully"

