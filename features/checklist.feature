Feature: Checklist Submission

Scenario: User enter checklist page

Given the main page of the site
And I logged in as "user@cucumber.checkin"
When I click "Recommend" message button
Then I should see checklist page

Scenario: Make result checklist page

Given I logged in as "user@cucumber.checklist"
And the checklist page of the site
When I click "Recommend" message button
When I answer the whole question
And I press "checklist_submit" button
Then a new article is shown

Scenario: See the result of recommendation

Given I recommended with something with "recommended@cucum.ber"
When I click "Articles" message button
Then I should see the articles page

Scenario: like the hobby

Given I recommended with something with "like@dislike.it"
When I click first "like" message button
And I click "Liked/Disliked Hobbies" message button
And I click first "Liked" message button
Then I can see the showliked page
And the message "Liked Hobby List"

