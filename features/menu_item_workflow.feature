Feature: As Admin,
  In order to be able to add dishes and other products to the system
  I would like be able to access an interface for Creating, updating and deleting MenuItems

  Background:
    Given the following MenuItems exist:
      | name    | price | description | ingredients | status |
      | Chicken | 20    |             |             | active |
      | Beef    | 30    | tasty       | salt        | active |
      
    And the following Menus exist:
      | title   | start_date | end_date   |
      | Monday  | 2015-01-01 |            |
      | Tuesday | 2015-01-02 | 2015-01-11 |
      
    And "Chicken" has been added as a MenuItem to "Monday"

    And I am logged in as admin
    And I am on the "Products" page

  Scenario: View index
    Then I should see an index of "Products"
    And I should see "Chicken"
    And I should see "20"
    And I should see 2 record rows

  @cloudinary
  Scenario: Create a new MenuItem
    When I click the "New Product" link
    And I fill in "Name" with "Pork"
    And I fill in "Price" with "25"
    And I fill in "Description" with "Lorem ipsum..."
    And I fill in "Ingredients" with "pork, onions..."
    And I attach "pork.jpg" to field "menu_item[image]"
    And I select "Menu Item Status" to "inactive"
    And I click "Create Menu item" button
    Then I should be on the view page for Menu Item "Pork"
    And I should see "25"
    And I should see "Lorem ipsum..."
    And I should see "pork, onions..."
    And I should see the image for Menu Item "Pork"
    And I should see "inactive"
    And I should see "Menu item was successfully created."

  @cloudinary
  Scenario: Edit existing MenuItem
    When I click the "edit" link for "Beef"
    Then I should be on the edit page for Menu Item "Beef"
    And I fill in "Name" with "Pork"
    And I fill in "Price" with "25"
    And I fill in "Description" with "Lorem ipsum..."
    And I fill in "Ingredients" with "pork, onions..."
    And I attach "pork.jpg" to field "menu_item[image]"
    And I click "Update Menu item" button
    Then I should be on the view page for Menu Item "Pork"
    And I should see "25"
    And I should see "Lorem ipsum..."
    And I should see "pork, onions..."
    And I should see the image for Menu Item "Pork"
    And I should see "Menu item was successfully updated."

  Scenario: View existing MenuItem
    When I click the "view" link for "Beef"
    And I should see "30"
    And I should see "tasty"
    And I should see "salt"
    Then I should be on the view page for Menu Item "Beef"

  Scenario: Delete existing MenuItem
    When I click the "delete" link for "Beef"
    Then I should see an index of "Products"
    And I should see "Menu item was successfully destroyed."
    And I should see 1 record rows

  Scenario: Update the MenuItem description
    When I click the "edit" link for "Beef"
    Then I should be on the edit page for Menu Item "Beef"
    When I fill in "Price" with "40"
    When I fill in "Description" with "Lorem ipsum..."
    When I fill in "Ingredients" with "pork, onions..."
    And I click "Update Menu item" button
    Then I should be on the view page for Menu Item "Beef"
    And I should see "40"
    And I should see "Lorem ipsum..."
    And I should see "pork, onions..."

  Scenario: Attempt to set MenuItem to 'inactive' status
    When I click the "edit" link for "Chicken"
    Then I should be on the edit page for Menu Item "Chicken"
    And I select "Menu Item Status" to "inactive"
    And I click "Update Menu item" button
    Then I should see "Status cannot be inactive since product is included in one or more menus"