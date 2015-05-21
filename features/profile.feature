Feature: Edit Profile

Scenario: User Profile

Given the main page of the site
And I logged in as "user@cucumber.profile"
When I click "Edit Profile" message button
Then I should see Profile page
And I should see my name "thisisBDD"
