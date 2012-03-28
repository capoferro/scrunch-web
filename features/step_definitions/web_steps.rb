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
    within('.ahri') do
      page.should have_content 'Ahri'
      page.should have_content '2825'
      page.should have_content 'Slash: 193'
    end

    within('.forge_guardian') do
      page.should have_content 'Forge Guardian'
      page.should have_content '3122'
      page.should have_content 'Maul: 156'
    end

    within('.ahri_t7_o1') do
      page.should have_content 'Ahri:T7-O1'
      page.should have_content '859'
      page.should have_content 'Ranged Attack: 52'
    end
  end

  within('.entities.healing') do
    within('.ahri') do
      page.should have_content 'Ahri'
      page.should have_content '815'
      page.should have_content 'Revive Companion: 423'
    end

    within('.forge_guardian') do
      page.should have_content 'Forge Guardian'
      page.should have_content '0'
      page.should_not have_content ':'
    end

    within('.ahri_t7_o1') do
      page.should have_content 'Ahri:T7-O1'
      page.should have_content '0'
      within('.max') do
        page.should_not have_content ':'
      end
    end
  end
end

And /^show me the page$/ do
  save_and_open_page
end

Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should see tabs for each encounter parsed from "([^\"]*)"$/ do |combat_log|
  case combat_log
  when "Ahri-vs-ForgeGuardian"
    within('.encounters') do
      page.should have_content('Encounter 1')
      page.should have_content('NPCs')
      within('ul.npcs') do
        page.should have_content('Forge Guardian')
      end
      page.should have_content('Players')
      within('ul.players') do
        page.should have_content('Ahri')
        page.should have_content('Ahri:T7-O1')
      end
    end
  
end
