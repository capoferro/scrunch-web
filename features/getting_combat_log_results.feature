Feature: getting combat log results for my combat log
  As a user
  In order to see how my in game combat performance is in chart format
  I want to be able to upload a combat log

  Scenario: Uploading a combat log file
    Given I am on the home page
    When I upload the combat log "Ahri-vs-ForgeGuardian"
    Then I should see the results of that combat log in chart format

  @pending
  Scenario: Uploading a malformed combat log
    Given I am on the home page
    When I upload the combat log "invalid-combat-log"
    Then I should see the error message "We're having some trouble with that combat log. The line 'abcdefg' cannot be parsed."
    
  # Not MVP
  @pending
  Scenario: Posting to the upload route outside the web ui
    
  @pending
  Scenario: Uploading a file with the same name as an existing file should not overwrite the old file # possibly a spec
