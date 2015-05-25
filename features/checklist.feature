Feature: Checklist Submission

Scenario: User enter checklist page

Given the main page of the site
When I click "Recommendation" message button
Then I should see checklist page

Scenario: User submit checklist

Given the checklist page of the site
When I fill in all questions
And I press "Magic Happens" button
Then I should see article page
