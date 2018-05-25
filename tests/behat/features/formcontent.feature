@webform
Feature: Webform Content Type
When I login to a Web Express website
As an authenticated user
I should be able to create, edit, and delete Webforms

  # 1) CHECK NODE ADD PRIVILEGES
  # 2) CHECK THAT SIMPLE NODE CAN BE CREATED AND REVISED
  # 3) CHECK EDITING AND DELETING PRIVILEGES ON THE CONTENT JUST MADE
  # 4) CHECK THAT DELETE BUTTON ACTUALLY WORKS
  # 5) CHECK MORE COMPLEX NODE CREATION

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
    And fill in "edit-title" with "Simple Form"
    And fill in "Body" with "Lorem ipsum dolor sit amet"
    When I press "edit-submit"
    And I should see "The new webform Simple Form has been created. Add new fields to your webform with the form below."
    And the URL should contain "webform/components"
    And I should see the link "Webform Results"
    And I should see the link "Form components"
And I should see the link “Conditionals”
And I should see the link “E-mails”
And I should see the link “Form settings”
And I should see “No Components, add a component below.”
And I fill in “edit-add-name” with “Name”
And I press “edit-add-add”
Then I should see “Edit component: Name”
And I press “edit-actions-submit”
Then I should see “New component Name added.”
And I follow “View”
Then I should see “Simple Form”
# GET THE PROPER TEXT FOR THESE NEXT TWO
And I should see an input field labeled “Name” with ID “edit-submitted-name”
And I should see an input button of value “Submit”


Scenario: The provide menu link box should be checked on node creation but remain unchecked if user chooses to uncheck that box.
Given I am logged in as a user with the "site_owner" role
    When I am at "node/add/webform"
    And  I fill in "edit-title" with "Form Menu Check Box"
    Then the "edit-menu-enabled" checkbox should be checked
    When I uncheck the box "edit-menu-enabled"
    And I press the "Save" button
    And I click "Edit"
    Then the checkbox "edit-menu-enabled" should be unchecked

  # 3) CHECK EDITING AND DELETING PRIVILEGES ON THE CONTENT JUST MADE
  Scenario Outline: Node Access -  Some roles can edit and delete Webform content
    Given I am logged in as a user with the <role> role
    And I am on "admin/content"
    And I follow "My Page"
    Then I should see the link "View"
    And I should see the link "Edit"
    And I should see the link "Edit Layout"
    And I should see the link "Revisions"
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

  Scenario: Node Access -  EditOnly can edit and revise but not delete node; can clear page cache
    Given I am logged in as a user with the "edit_only" role
    And I am on "admin/content"
    And I follow "My Page"
    Then I should see the link "View"
    And I should see the link "Edit"
    And I should not see the link "Edit Layout"
    And I should see the link "Revisions"
    And I should see the link "Clear Page Cache"
    When I follow "Edit"
    Then I should see "This document is now locked against simultaneous editing."
    And I should not see an "#edit-delete" element
    And I press "Cancel edit"

  # Page assigned to edit_my_content role is assigned on cu_page.feature:17
  Scenario: Node Access -  EditMyContent can edit Basic Pages and Persons if owner; cannot delete; can clear page cache
    Given I am logged in as a user with the "edit_my_content" role
    And I am on "edit-my-content-page"
    Then I should see the link "View"
    And I should see the link "Edit"
    And I should not see the link "Edit Layout"
    And I should not see the link "Clear Page Cache"
    When I follow "Edit"
    # @todo move this to a locked document test or remove as a duplicate.
    # Then I should see "This document is now locked against simultaneous editing."
    Then I should not see an "#edit-delete" element
    When I fill in "Body" with "changing content..."
    And I press "Save"
    Then I should see "changing content..."
    When I follow "Edit"
    Then I should see the link "Revisions"

  # 4) CHECK THAT DELETE BUTTON ACTUALLY WORKS
  Scenario: Verify that the Delete button actually works
    Given I am logged in as a user with the "site_owner" role
    And I am on "admin/content"
    And I follow "My Page"
    And I follow "Edit"
    And I press "Delete"
    Then I should see "Are you sure you want to delete My Page?"
    And I press "Delete"
    Then I should see "Basic page My Page has been deleted."
    And I am on "/"

  # 5) CHECK MORE COMPLEX NODE CREATION
  Scenario: A graphic can be uploaded to a Webform content
    Given I am logged in as a user with the "site_owner" role
    And I am on "node/add/webform"
    And fill in "edit-title" with "About Ralphie"
    And fill in "Body" with "Ralphie the Buffalo is the name of the live mascot of the University of Colorado Buffaloes."
    And I fill in "edit-field-photo-und-0-alt" with "Ralphie Buffalo with handlers"
    And I attach the file "ralphie.jpg" to "edit-field-photo-und-0-upload"
    And I press "edit-field-photo-und-0-upload-button"
    Then I should see "File information"
    And I should see "ralphie.jpg"
    And I should see "Insert"
    And I press "edit-submit"
    Then I should be on "/about-ralphie"
    And I should see "About Ralphie"
    And I should see "Ralphie the Buffalo is the name of the live mascot of the University of Colorado Buffaloes."

  Scenario: The provide menu link box should be checked on node creation but remain unchecked if user chooses to uncheck that box.
    Given I am logged in as a user with the "site_owner" role
    When I go to "node/add/webform"
    And I fill in "edit-title" with "Not In Menu"
    Then the "edit-menu-enabled" checkbox should be checked
    When I uncheck "edit-menu-enabled"
    And I press "Save"
    # ADD CHECK FOR PAGE TITLE
    Then I should see "Not In Menu"
    And I follow "Edit"
    Then the checkbox "edit-menu-enabled" should be unchecked
    
