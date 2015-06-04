Given(/^I recommended with something with "(.*?)"$/) do |arg1|
   steps %Q{
   Given I logged in as "#{arg1}"
   And the checklist page of the site
   When I click "Recommend" message button
   When I answer the whole question
   And I press "checklist_submit" button
}

end

Then(/^I should see the articles page$/) do
    assert page.current_path == "/articles/board"
end


Then(/^I should see checklist page/) do
    assert page.current_path == pages_checklist_path
end

Given(/^the checklist page of the site/) do
    steps %Q{
        Given the main page of the site
        When I click "Recommend" message button
        Then I should see checklist page
    }
end

When(/^I fill in all questions/) do
    for num in 1..28
        choose("q"+num.to_s, :match => :first)
    end
    

end

Then(/^I should see article page/) do
    article_cnt = Article.count
    assert page.current_path == articles_path + '/' + article_cnt.to_s
end

When(/^I answer the whole question$/) do
    (1..28).each do |i|
        # find("q"+ i.to_s)
        choose("q"+ i.to_s + "_1")
    end
    
Weight.create(weightList: [[{prop: "rich", weight: 1.0}],
[{prop: "team", weight: 0.333}, {prop: "online", weight: 0.5}],
[{prop: "solo", weight: 0.5}, {prop: "writing", weight: 0.333}],
[{prop: "ps", weight: 0.333}],
[{prop: "ps", weight: 0.333}, {prop: "observe", weight: 0.25}],
[{prop: "competitive", weight: 0.2}, {prop: "persistence", weight: 0.2}],
[{prop: "collecting", weight: 0.333}],
[{prop: "active", weight: 0.333}, {prop: "team", weight: 0.333}],
[{prop: "ps", weight: 0.333}, {prop: "persistence", weight: 0.2}],
[{prop: "gamble", weight: 0.333}, {prop: "competitive", weight: 0.2}],
[{prop: "mechanic", weight: 0.5}],
[{prop: "competitive", weight: 0.2}, {prop: "persistence", weight: 0.2}],
[{prop: "observe", weight: 0.25}, {prop: "persistence", weight: 0.2}],
[{prop: "competitive", weight: 0.2}, {prop: "team", weight: 0.333}],
[{prop: "handuse", weight: 0.333}],
[{prop: "collecting", weight: 0.333}],
[{prop: "competitive", weight: 0.2}],
[{prop: "active", weight: 0.333}, {prop: "art", weight: 0.25}],
[{prop: "art", weight: 0.25}, {prop: "writing", weight: 0.333}],
[{prop: "solo", weight: 0.5}, {prop: "online", weight: 0.5}],
[{prop: "offline", weight: 1.0}, {prop: "observe", weight: 0.25}],
[{prop: "art", weight: 0.25}, {prop: "persistence", weight: 0.2}],
[{prop: "mechanic", weight: 0.5}, {prop: "handuse", weight: 0.333}],
[{prop: "gamble", weight: 0.333}, {prop: "active", weight: 0.333}],
[{prop: "writing", weight: 0.333}, {prop: "art", weight: 0.25}],
[{prop: "collecting", weight: 0.333}, {prop: "handuse", weight: 0.333}],
[{prop: "gamble", weight: 0.333}, {prop: "observe", weight: 0.25}],
[{prop: "mechanic", weight: 0.5}]])

end

Then(/^a new article is shown$/) do
    assert page.has_content?("Recommend Point")
end

When(/^I click first "(.*?)" message button$/) do |arg1|
    click_button(arg1, :match => :prefer_exact)
end

Then(/^I can see the showliked page$/) do
    puts page.current_path
    assert page.current_path == "/pages/showliked"
end

Then(/^the message "(.*?)"$/) do |arg1|
    assert_text(arg1)
end

