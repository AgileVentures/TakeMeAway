Feature: As Admin,
  In order to be able to add dishes and other products to the system
  I would like be able to access an interface for Creating, updating and deleting MenuItems

  Background:
    Given the following MenuItems exist:
      | name    | price | description | ingredients | status |
      | Chicken | 20    |             |             | active |
      | Beef    | 30    | tasty       | salt        | active |
      | Pasta   | 10    | homemade    | wheat       | active |
      | Ramen   | 25    | spicy       | noodles     | active |
      
    And the following Menus exist:
      | id | title    | start_date | end_date   |
      | 1  | Monday   | 2015-01-01 | today      |
      | 2  | Tuesday  | 2015-01-02 | 2015-01-11 |
      | 3  | NextWeek | next_week  | next_week  |
      
    And the following users exist:
      | name    | email           | password | is_admin |
      | Admin   | admin@tma.org   | password | true     |
      | Client1 | client@tma.org  | password | false    |
      | Client2 | client2@tma.org | password | false    |
      
    And the following Orders exist:
      | order[id] | user[user] | order[status] | menu_item[name] | menu[id] |
      | 1         | Client1    | processed     | Chicken         | 1        |
      | 2         | Client2    | pending       | Chicken         | 2        |
      | 3         | Client1    | canceled      | Pasta           | 2        |
      
    And "Chicken" has been added as a MenuItem to "Monday"

    And I am logged in as admin
    And I am on the "Products" page

  Scenario: View index
    Then I should see an index of "Products"
    And I should see "Chicken"
    And I should see "20"
    And I should see 4 record rows

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
    And I should see 3 record rows

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
    
  Scenario: Attempt to delete MenuItem that is in a pending order
    Given "Beef" has been added as a MenuItem to "Monday"
    When I click the "delete" link for "Beef"
    Then I should see "Menu item could not be destroyed."
    
  Scenario: Attempt to delete MenuItem that is in a completed order
    Given "Beef" has been added as a MenuItem to "Monday"
    And "Beef" has been added to order 1 from Menu "Monday"
    When I click the "delete" link for "Beef"
    Then I should see "Menu item could not be destroyed."
    
  Scenario: Attempt to delete MenuItem that is included in canceled order
    Given "Beef" has been added as a MenuItem to "Monday"
    And "Beef" has been added to order 3 from Menu "Monday"
    When I click the "delete" link for "Beef"
    Then I should see "Menu item could not be destroyed."
    
  Scenario: Attempt to delete MenuItem that is included in a current menu
    Given "Ramen" has been added as a MenuItem to "Monday"
    When I click the "delete" link for "Ramen"
    Then I should see "Menu item could not be destroyed."
    
  Scenario: Attempt to delete MenuItem that is included in a future menu
    Given "Ramen" has been added as a MenuItem to "NextWeek"
    When I click the "delete" link for "Ramen"
    Then I should see "Menu item could not be destroyed."
  
  