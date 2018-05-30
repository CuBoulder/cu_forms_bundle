@webform
Feature: Webform Blocks
When a Webform has been created
As a user with the proper role
I should be able to export a Webform Block

# 1) TEST BLOCK CREATION
# 2) TEST THAT A SIMPLE BLOCK CAN BE CREATED AND REVISED
# 3) TEST EDITING AND DELETING PRIVILEGES ON THE BLOCK JUST MADE
# 4) TEST THAT THE DELETE BUTTON ACTUALLY WORKS
# 5) TEST MORE COMPLEX BLOCK CREATION

# 1) TEST BLOCK CREATION
Scenario: A Webform can be exported as a block
Given I am logged in as a user with the "site_owner" role
And I am on "admin/content"
And I follow "Simple Test Form"
And I follow "Edit Webform"
And I follow "Form settings"
And I click "Advanced settings"
Then I should see "If enabled this webform will be available as a block."
And the checkbox "edit-block" should not be checked
And I check "edit-block"
And I click "Save"
Then I should see "The form settings have been updated."
# AND THEN I SHOULD GO HERE AND SEE THE BLOCK


# IF ADVANCED LAYOUT IS ENABLED, VERIFY THAT BLOCK CAN BE WRAPPED IN BLOCK WRAPPER.

 Scenario: Block Access: An anonymous user cannot add a Text Block block
  When I am on "block/add/block"
  Then I should see "Access denied"
  
# 2) TEST THAT A SIMPLE BLOCK CAN BE CREATED AND REVISED
 Scenario: Block Functionality - A very simple Text Block can be created 
 Given I am logged in as a user with the "site_owner" role
  And I am on "block/add/block"
  And fill in "edit-label" with "Text Block Label"
  And fill in "edit-title" with "My Text Block Title"
And fill in "Body" with "An informative block of text about our program"
  When I press "edit-submit"
  Then I should be on "block/text-block-label/view"
 And I should see "My Text Block Title"
 And I should see "An informative block of text about our program"
 
#  2.5 CREATE REVISIONS TO THE BLOCK ABOVE
Scenario: Block Functionality - Create Revision of block
Given I am logged in as a user with the "site_owner" role
And I am on "admin/content/blocks"
And I follow "Text Block Label"
And I follow "Edit Block"
And fill in "Body" with "Academics, Research and Student Life"
 And I press "Save"
 Then I should see "Text Block My Text Block Title has been updated."

# 3) TEST EDITING AND DELETING PRIVILEGES ON THE BLOCK JUST MADE

Scenario Outline: Block Access - SE, SO and above can edit, revise, theme and delete Text Block
Given I am logged in as a user with the <role> role
And I am on "admin/content/blocks"
And I follow "Text Block Label"
Then I should see the link "View"
And I should see the link "Edit Block"
And I should see the link "Revisions" 
And I should see the link "Block Designer"
And I should see the link "Delete Block"
When I follow "Edit Block"
Then I should see "Edit Text Block: Text Block Label"
And I should see an "#edit-delete" element
And I follow "View"

Examples: 
| role |
| developer       | 
| administrator   | 
| site_owner      | 
| content_editor  |
| site_editor |


Scenario: Block Access - The EditOnly role can edit, revise, theme but not delete Text Block content
Given I am logged in as a user with the "edit_only" role
And I am on "admin/content/blocks"
And I follow "Text Block Label"
Then I should see the link "View"
And I should see the link "Edit Block"
And I should see the link "Revisions"
And I should see the link "Block Designer"
And I should not see the link "Delete Block"
When I follow "Edit Block"
Then I should see "Edit Text Block: Text Block Label"
And I should not see an "#edit-delete" element
And I follow "View"

Scenario: Block Access - EditMyContent cannot access or edit block content
Given I am logged in as a user with the "edit_my_content" role
And I am on "admin/content/blocks"
Then I should see "Access denied"
And I go to "block/text-block-label/edit"
Then I should see "Access denied"

# 4) TEST THAT THE DELETE BUTTON ACTUALLY WORKS
Scenario: Verify that the Delete button actually works
 Given I am logged in as a user with the "site_owner" role
And I go to "block/text-block-label/edit"
 And I press "Delete"
 Then I should see "Are you sure you want to delete My Text Block Title?"
  And I press "Delete"
 Then I should see "Text Block My Text Block Title has been deleted"
And I am on "/"

# 5) TEST MORE COMPLEX BLOCK CREATION

# NOTE THAT THE INSERT BUTTON IS IMPOSSIBLE TO TARGET AT THIS TIME

Scenario: A graphic can be uploaded to a Text Block
  Given I am logged in as a user with the "site_owner" role
  And I am on "block/add/block"
  And fill in "edit-label" with "My Text Block"
  And fill in "edit-title" with "My New Text Block"
  And fill in "Body" with "Lorem ipsum dolor sit amet"
  And I attach the file "cupcakes.jpg" to "edit-field-block-photo-und-0-upload"
  And I fill in "edit-field-block-photo-und-0-alt" with "Lavender and lemony goodness"
  And I press "edit-field-block-photo-und-0-upload-button"
 Then I should see "File information"
 And I press "Save"
 Then I should see "My New Text Block"
 And I should see "Lorem ipsum dolor sit amet"
