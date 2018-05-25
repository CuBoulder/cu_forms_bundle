@webform @feedback
Feature: Webform Feedback form
When I create a webform
As an authenticated user
A feedback form is automaticaly created

 Scenario: A site_owner should see no webforms after install on feedback form settings page
    Given I am logged in as a user with the "site_owner" role
    And am on "admin/settings/forms/feedback"
    Then I should see "There are no published webforms available"

 Scenario Outline: An site owner/administrator/developer should be able to access the settings feedback page
    Given I am logged in as a user with the <role> role
    When I am at "admin/settings/site-configuration/feedback"
    Then I should not see <message>

    Examples:
      | role           | message         |
      | site_owner     | "Access denied" |
      | administrator  | "Access denied" |
      | developer      | "Access denied" |


@clean_install
  Scenario: A site owner should see a webform in the feedback form list of one exists
    Given I am logged in as a user with the "site_owner" role
    And am on "node/add/webform"
    And fill in "Title" with "Contact Form"
    When I press the "Save" button
    And I go to "admin/settings/forms/feedback"
    Then I should not see "There are no published webforms available"
