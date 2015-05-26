Then(/^I should see checklist page/) do
    assert page.current_path == pages_checklist_path
end

Given(/^the checklist page of the site/) do
    steps %Q{
        Given the main page of the site
        When I click "Recommendation" message button
        Then I should see checklist page
    }
end

When(/^I fill in all questions/) do
    for num in 1..28
        choose("q"+num.to_s, :match => :first)
    end
end

Then(/^I should see article page/) do
    assert page.current_path == articles_path + '/2'
end
