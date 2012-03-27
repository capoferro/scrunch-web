Given /^I am on the (.*)$/ do |page|
  visit(case page
        when /home\s?page/
          '/'
        else
          raise "#{page} not defined in step"
        end)
end

When /^I upload the combat log "([^\"]*)"$/ do |log_name|
  attach_file('combat_log_file', @filename = File.join(Rails.root, 'spec', 'fixtures', 'data', 'combat_logs', "#{log_name}.txt"))
  click_button 'Upload'
end

Then /^I should see the results of that combat log in chart format$/ do
  @filename.should_not be_nil
  step 'I should see "Ahri"'
  step 'I should see "Forge Guardian"'
  step 'I should see "Ahri:T7-O1"'
end

And /^show me the page$/ do
  save_and_open_page
end

Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end
