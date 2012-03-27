Feature: viewing a specific encounter captured by a combat log
  As a user who has uploaded a combat log
  In order to get a better feel for how my damage looks for a given encounter rather than just over all and so I don't have to split my combat logs manually
  I want my log split into specific encounters automatically and placed into separate views that operate like the overall view but limited to just one encounter

  @pending
  Scenario: viewing the first encounter of a combat log
    Given I am viewing the results page for the combat log "Ahri-Missions"
    Then I should see "Encounter 1"
    And I should see the following participants for "Encounter 1"
         | name                    | count |
         | Manka Cat               |     2 |
         | Flesh Raider Loremaster |     1 |
         | etc...                  |     1 |
    When I click on "Encounter 1"
    Then I should see the damage row for "Manka Cat 1"
    And I should see the damage row for "Manka Cat 2"
    And I should not see the damage row for "Other mob in other encounter"
