Feature: User sign up

Scenario: User sign up success
    Given the main page of the site
    When I click "Sign up" message button
    Then "Sign up" page should be opened
    When I fill E-mail, Nickname, Password, Password confirm
    And I press "signup_submit_button" button
    Then the main page should be seen and I should see welcoming message

Scenario: User sign up failure
    Given the main page of the site
    When I click "Sign up" message button
    Then "Sign up" page should be opened
    When I fill E-mail, Nickname, Password, Password confirm uncorrectly
    And I press "signup_submit_button" button
    Then the failure message given

