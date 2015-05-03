Feature: As Admin,
  In order to be able to add dishes and other products to the system
  I would like be able to access an interface for Creating, updating and deleting MenuItems

  Background:
    Given the following MenuItems exits:
      | name    | price |
      | Chicken | 20    |
      | Beef    | 30    |

    And I am logged in as admin
    And I am on the "Products" page

  Scenario: View index
    Then I should see an index of "Products"
    And I should see 2 record rows

  Scenario: Create a new MenuItem
    When I click the "New Product" link
    And I fill in "Name" with "Pork"
    And I fill in "Price" with "25"
    And I click "Create Menu item" button
    Then I should be on the product page for "Pork"

  Scenario: Edit existing MenuItem


  Scenario: View existing MenuItem


  Scenario: Delete exiting MenuItem