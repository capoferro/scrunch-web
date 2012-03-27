Feature: viewing combat log participant's details
  As a user who has already uploaded a combat log
  In order to get more specific information regarding a specific participant's actions during combat
  I would like to be able to click a participant in the results table and have more details displayed.

  @pending
  Scenario: viewing details
    Given I am viewing the results page for the combat log "Ahri-vs-ForgeGuardian"
    When I click "Ahri"
    Then I should see "Force Charge" with "389" damage
    And I should see "Smash" with "1400" damage
    And I should see "FreeAttackName" with "1000" damage
    And I should see "Health Potion" with "900" healing
