Feature: User login/logout

Scenario: User log in success

Given the main page of the site
And I signed up as "user@cucumber.bdd" and "thisisBDD" and "cucumberbdd"
When I click "Log in" message button
Then I "login" page should be opened
When I fill E-mail and password as "user@cucumber.bdd" and "cucumberbdd" in login page
And I press "login_submit_button" button
Then the main page should be seen
And I should see the message " Logged in Successfully"


Scenario: User log in failure

Given the main page of the site
And I signed up as "user@cucumber.bdd" and "thisisBDD" and "cucumberbdd"
When I click "Log in" message button
Then I "login" page should be opened
When I fill E-mail and password as "user@cucumber.bdd" and "wrongpassword" in login page
And I press "login_submit_button" button
Then I should see the message "Incorrect email and password combination"


Scenario: User log out

Given the main page of the site
And I logged in as "user@cucumber.logout"
When I click "Log out" message button
Then the main page should be seen
And I should see the message "logged out successfully"
