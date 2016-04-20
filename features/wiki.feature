Feature: Wiki

Scenario: wiki page view

Given the main page of the site
And I logged in as "user@wiki.input"
When I click "Wiki" message button
Then the wiki page is seen

Scenario: Make a Hobby

Given the wiki page of the site
When I press "hobby_create_trigger" button
Then the hobby create page is seen
