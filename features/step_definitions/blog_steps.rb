Given /^I am on the new post page$/ do
  visit(new_post_path)
end

When /^I fill out all the required new post form fields$/ do
  fill_in("Title", with: "hello world")
  fill_in("Body", with: "hello body")
end

When /^I submit the form$/ do
  pending
end

Then /^I should see "(.*?)"$/ do |arg1|
  pending
end

Then /^I should be on the posts page$/ do
  pending
end
