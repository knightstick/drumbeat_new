When(/^I click the "(.*?)" link$/) do |link|
  click_link link
end

Given /^I visit the "(.*?)" page$/ do |address|
	visit "/#{address}"
end

When /^I click the "(.*?)" button$/ do |button|
	click_button "#{button}" 
end	

Then /^I should see "(.*?)"$/ do |content|
	expect(page).to have_content content
end