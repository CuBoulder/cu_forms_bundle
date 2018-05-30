@webform
Feature: Webform Content Type
When I login to a Web Express website
As an authenticated user
I should be able to create, edit, and delete Webforms


  # 1) CHECK NODE ADD PRIVILEGES
  # 2) CHECK THAT SIMPLE NODE CAN BE CREATED AND REVISED
  # 3) CHECK EDITING AND DELETING PRIVILEGES ON THE CONTENT JUST MADE
  # 4) CHECK MORE COMPLEX NODE CREATION
  # 5) CHECK WEBFORM RESULTS

  # 1) CHECK NODE ADD PRIVILEGES (VERIFY WITH THE NEW ROLES)
  Scenario Outline: Node Access - Some roles can add Webform content
    Given I am logged in as a user with the <role> role
    When I go to "node/add/webform"
    Then I should see <message>

    Examples:
      | role            | message          |
      | developer       | "Create Webform" |
      | administrator   | "Create Webform" |
      | site_owner      | "Create Webform" |
      | content_editor  | "Create Webform" |
      | edit_my_content | "Access denied"  |
      | site_editor     | "Create Webform" |
      | edit_only       | "Access denied"  |
      | form_manager    | "Create Webform" |

  Scenario: Node Access -  An anonymous user cannot add Webform content
    When I am on "node/add/webform"
    Then I should see "Access denied"
  
  #  2) CHECK THAT SIMPLE NODE CAN BE CREATED
  Scenario: Node Functionality - A very basic Webform node can be created
    Given I am logged in as a user with the "site_owner" role
    And I am on "node/add/webform"
    And fill in "edit-title" with "Simple Test Form"
    And fill in "Body" with "Lorem ipsum dolor sit amet"
    When I press "edit-submit"
    And I should see "The new webform Simple Test Form has been created. Add new fields to your webform with the form below."
    And the URL should contain "webform/components"
    And I should see the link "Webform Results"
    And I should see the link "Form components"
And I should see the link "Conditionals"
And I should see the link "E-mails"
And I should see the link "Form settings"
And I should see "No Components, add a component below."
And I fill in "edit-add-name" with "Name"
And I press "edit-add-add"
Then I should see "Edit component: Name"
And I press "Save component"
Then I should see "New component Name added."
And I follow "View"
Then I should see "Simple Test Form"
And I should see a "#edit-submitted-name" element
And I should see an input button of value "Submit"

Scenario: The provide menu link box should be checked on node creation but remain unchecked if user chooses to uncheck that box.
Given I am logged in as a user with the "site_owner" role
And I am on "admin/content"
And I follow "Simple Test Form"
Then the "edit-menu-enabled" checkbox should be checked
When I uncheck the box "edit-menu-enabled"
And I press the "Save" button
And I click "Edit"
Then the checkbox "edit-menu-enabled" should be unchecked
    
Scenario: The component drop-down should be populated with all allowed options
Given I am logged in as a user with the "site_owner" role
And I am on "admin/content"
And I follow "Simple Test Form"
And I follow "Edit Webform"
Then I select "Context (all)" from "edit-add-type"
And I select "Date" from "edit-add-type"
And I select "E-mail" from "edit-add-type"
And I select "Fieldset" from "edit-add-type"
And I select "File" from "edit-add-type"
And I select "Grid" from "edit-add-type"
And I select "Hidden" from "edit-add-type"
And I select "Markup" from "edit-add-type"
And I select "Number" from "edit-add-type"
And I select "Page break" from "edit-add-type"
And I select "Select options" from "edit-add-type"
And I select "Textarea" from "edit-add-type"
And I select "Textfield" from "edit-add-type"
And I select "Time" from "edit-add-type"

  # 3) CHECK EDITING AND DELETING PRIVILEGES ON THE CONTENT JUST MADE - ONLY SOME ACCESS EDITING FUNCTIONALITY
  Scenario Outline: Node Access -  Some roles can edit and delete Webform content
    Given I am logged in as a user with the <role> role
    And I am on "admin/content"
    And I follow "Simple Test Form"
    Then I should see the link "View"
    And I should see the link "Edit"
    And I should see the link "Edit Layout"
    And I should see the link "Webform Results"
    And I should see the link "Clear Page Cache"
    When I follow "Edit"
    Then I should see "This document is now locked against simultaneous editing."
    And I should see an "#edit-delete" element
    And I press "Cancel edit"

    Examples:
      | role           |
      | developer      |
      | administrator  |
      | site_owner     |
      | content_editor |
      | site_editor    |
      | form_manager   |


 # 4) CHECK MORE COMPLEX NODE CREATION
 @javascript
  Scenario: More complex forms can be created
    Given I am logged in as a user with the "site_owner" role
    And I am on "admin/content"
    And I follow "Simple Test Form"
    And I follow "Conditionals"
    Then I should see "There are no conditional actions on this form"
    And I follow "E-mails"
    And I fill in "edit-email-option-custom" with "myname@example.com"
    And I press "Add"
    Then I should see "E-mail to address"
    And I press "Save e-mail settings"
    Then I should see "myname@example.com"
    And I follow "Form settings"
    And I fill in "Confirmation message" with "Thank you for submitting this form"
    And I click "Advanced settings"
    Then I should see "Available as block"
    And I press "Save configuration"
    Then I should see "The form settings have been updated."
    
# 5) CHECK WEBFORM RESULTS
  Scenario: Submitting a form creates results
    Given I am logged in as a user with the "site_owner" role
    And I am on "admin/content"   
    And I follow "Simple Test Form"
    And I fill in "Name" with "Englebert Humperdink"
    And I press "Submit"
    Then I should see "Thank you for submitting this form"
    And I follow "Go back to the form"
    And I follow "Webform results"
    Then I should not see "There are no submissions for this form"
    And I should see the link "sort by Submitted"
