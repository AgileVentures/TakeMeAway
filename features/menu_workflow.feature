Feature:
  As an Admin
  In order to be able to present my daily menu to customers
  I would like be able to access an interface for creating, populating, updating and deleting Menus

  Background:
    Given the following Menus exist:
      | title   | start_date | end_date   |
      | Monday  | 2015-01-01 | 2015-01-05 |
      | Tuesday | 2015-01-02 | 2015-01-11 |

    And the following MenuItems exist:
      | name    | price | status |
      | Chicken | 20    | active |
      | Beef    | 30    | active |

    And I am logged in as admin
    And I am on the "Menus" page
    And I click the "All" link

  Scenario: View index
    Then I should see an index of "Menus"
    And I should see 2 record rows

  @javascript
  Scenario: Create a menu
    When I click the "New Menu" link
    And I fill in "Title" with "Monday menu"
    And I select the date "2015-05-08" in datepicker for Menu Start Date
    And I select the date "2015-05-08" in datepicker for Menu End Date
    And I click "Create Menu" button
    Then I should be on the view page for Menu "Monday menu"
    And I should see "Menu was successfully created"

  @javascript
  Scenario: Edit existing menu
    When I click the "edit" link for "Monday"
    And I fill in "Title" with "Wednesday"
    And I select the date "2015-05-08" in datepicker for Menu Start Date
    And I select the date "2015-05-08" in datepicker for Menu End Date
    And I click "Update Menu" button
    Then I should be on the view page for Menu "Wednesday"
    And I should see "Menu was successfully updated"

  Scenario: View existing Menu
    When I click the "view" link for "Monday"
    Then I should be on the view page for Menu "Monday"
    And I should see "Monday"
    And I should see "Monday 2015-01-01"

  Scenario: Delete existing Menu
    When I click the "delete" link for "Tuesday"
    And I should see "Menu was successfully destroyed."
    And I click the "All" link
    Then I should see an index of "Menus"
    And I should see 1 record rows

 @javascript
 Scenario: Add MenuItem to menu
   When I click the "edit" link for "Monday"
   And I click "Add New Menu items menu"
   And I select "first Menu Item" to "Chicken"
   And I fill in "first Daily stock" with "20"
   And I click "Add New Menu items menu"
   And I select "second Menu Item" to "Beef"
   And I fill in "second Daily stock" with "10"
   And I click "Update Menu" button
   Then "Chicken" should be added as a MenuItem to "Monday"
   Then "Beef" should be added as a MenuItem to "Monday"

 Scenario: Remove MenuItem from menu
   Given "Chicken" has been added as a MenuItem to "Monday"
   And  "Beef" has been added as a MenuItem to "Monday"
   And I click the "edit" link for "Monday"
   And I check "first Delete"
   And I click "Update Menu" button
   Then "Chicken" should not be a MenuItem to "Monday"




