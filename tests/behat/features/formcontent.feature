 @webform
 Feature: Webform Content Type
When I login to a Web Express website
As an authenticated user
I should be able to create, edit, and delete Webforms

Scenario: The provide menu link box should be checked on node creation but remain unchecked if user chooses to uncheck that box.
    Given I am logged in as a user with the "site_owner" role
    When I am at "node/add/webform"
    And  I fill in "edit-title" with "New Webform"
    Then the "edit-menu-enabled" checkbox should be checked
    When I uncheck the box "edit-menu-enabled"
    And I press the "Save" button
    And I click "Edit"
    Then the checkbox "edit-menu-enabled" should be unchecked
