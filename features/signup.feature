Feature: User sign up

Scenario: User sign up success
    Given the main page of the site
    When I click "Sign up" message button
    Then “signup_page” should be opened.
    When I fill E-mail, Nickname, Password, Password confirm
    And I press “submit” button
    Then the main page should be seen and I should see welcoming message
