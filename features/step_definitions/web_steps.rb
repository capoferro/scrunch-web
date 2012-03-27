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
  within('.entities.damage') do
    within('.Ahri') do
      page.should have_content 'Ahri'
      page.should have_content '2825'
      page.should have_content 'MAX SKILL: MAX DAMAGE'
    end

    within('.Forge_Guardian') do
      page.should have_content 'Forge Guardian'
      page.should have_content '3122'
      page.should have_content 'MAX SKILL: MAX DAMAGE'
    end

    within('.Ahri_T7-O1') do
      page.should have_content 'Ahri:T7-O1'
      page.should have_content '859'
      page.should have_content 'MAX SKILL: MAX DAMAGE'
    end
  end

  within('#healing-table') do
    within('.Ahri') do
      page.should have_content 'Ahri'
      page.should have_content '815'
      page.should have_content 'MAX SKILL: MAX DAMAGE'
    end

    within('.Forge_Guardian') do
      page.should have_content 'Forge Guardian'
      page.should have_content '0'
      page.should have_content 'MAX SKILL: MAX DAMAGE'
    end

    within('.Ahri_T7-O1') do
      page.should have_content 'Ahri:T7-O1'
      page.should have_content '0'
      page.should have_content 'MAX SKILL: MAX DAMAGE'
    end
  end
end

And /^show me the page$/ do
  save_and_open_page
end

Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end
