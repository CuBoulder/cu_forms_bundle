@webform @feedback
Feature: Feedback Form places an existing Webform as a popup
In order to create a site feedback form
An authenticated user with the proper role
Should be able to select a published form as the site feedback form

 Scenario: A site_owner should see no webforms after install on feedback form settings page
    Given I am logged in as a user with the "site_owner" role
    And am on "admin/settings/forms/feedback"
    Then I should see "There are no published webforms available"

#SOME ROLES CAN SELECT A FEEDBACK FORM AND SET OPTIONS FOR IT
 @javascript
Scenario Outline: Access - Devs, Admins, SOs and ConMgrs can see all the options for the Feedback Form
 Given I am logged in as a user with the <role> role
 And am on "admin/settings/forms/feedback"
 Then I should see "Available Webforms"
 And I should see "Feedback Button Label"
 And I should see "Feedback Button Color"
 And I should see "Feedback Form Presentation"
    
Examples:
    | role            | 
    | developer       | 
    | administrator   | 
    | site_owner      | 
    | configuration_manager |

# SOME ROLES CAN NOT SELECT A FEEDBACK FORM

Scenario Outline: Access - Most roles cannot access feedback form settings
Given I am logged in as a user with the <role> role
And am on "admin/settings/forms/feedback"
Then I should see "Access denied"

Examples:
| role |
| content_editor |
| edit_my_content  | 
| site_editor      | 
| edit_only        | 
| access_manager   | 

Scenario: Access - An anonymous user should not be able to access feedback form settings
 When I am on "admin/settings/forms/feedback"
Then I should see "Access denied"

@clean_install
  Scenario: Access - A site owner should see a webform in the feedback form list of one exists
    Given I am logged in as a user with the "site_owner" role
    And am on "node/add/webform"
    And fill in "Title" with "Contact Form"
    When I press the "Save" button
    And I go to "admin/settings/forms/feedback"
    Then I should not see "There are no published webforms available"
