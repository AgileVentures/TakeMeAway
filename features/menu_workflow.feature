Feature:
  As an Admin
  In order to be able to present my daily menu to customers
  I would like be able to access an interface for creating, populating, updating and deleting Menus

  Background:
    Given the following Menus exist:
      | title    | start_date | end_date   |
      | Monday   | 2015-01-01 | 2015-01-05 |
      | Tuesday  | 2015-01-02 | 2015-01-11 |
      | Thursday | 2015-01-03 | 2015-01-11 |
      | Friday   | 2015-01-04 | 2015-01-11 |
      | Saturday | 2015-01-05 | 2015-01-11 |
      | Today    | today      | today      |
      | ThisWeek | this_week  | this_week  |
      | NextWeek | next_week  | next_week  |

    And the following MenuItems exist:
      | name    | price | status |
      | Chicken | 20    | active |
      | Beef    | 30    | active |
      | Pasta   | 10    | inactive |

    And I am logged in as admin
    And I am on the "Menus" page
    And I click the "All" link

  Scenario: View index
    Then I should see an index of "Menus"
    And I should see 8 record rows
    
  Scenario: View index for this week
    When I click the "Current week" link
    Then I should see an index of "Menus"
    And I should see 2 record rows
    And I should see "Today"
    And I should see "ThisWeek"
    And I should not see "Monday"
    And I should not see "NextWeek"

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
  Scenario: Attempt to create menu with end_date earlier than start_date
    When I click the "New Menu" link
    And I fill in "Title" with "Monday menu"
    And I select the date "2015-05-08" in datepicker for Menu Start Date
    And I select the date "2015-05-07" in datepicker for Menu End Date
    And I click "Create Menu" button
    Then I should see "End date must be not be earlier than start date"

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
    Given "Chicken" has been added as a MenuItem to "Tuesday"
    And  "Beef" has been added as a MenuItem to "Tuesday"
    When I click the "delete" link for "Tuesday"
    And I should see "Menu was successfully destroyed."
    And I click the "All" link
    Then I should see an index of "Menus"
    And I should see 7 record rows

 @javascript
 Scenario: Add MenuItem to menu
   When I click the "edit" link for "Monday"
   And I click "Add Item"
   And I should not be able to select "Pasta"
   And I select "first Menu Item" to "Chicken"
   And I fill in "first Daily stock" with "20"
   And I click "Add Item"
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

 @javascript
 Scenario: Add conflicting MenuItem to menu
   Given "Chicken" has been added as a MenuItem to "Thursday"
   And "Beef" has been added as a MenuItem to "Friday"
   When I click the "edit" link for "Friday"
   And I click "Add Item"
   And I select "first Menu Item" to "Chicken"
   And I fill in "first Daily stock" with "10"
   And I click "Update Menu" button
   Then I should see "Item 'Chicken' is included in overlapping menu 'Thursday'"
   
 @javascript
 Scenario: Add conflicting MenuItem(s) to menu
    Given "Chicken" has been added as a MenuItem to "Friday"
    And "Beef" has been added as a MenuItem to "Thursday"
    When I click the "edit" link for "Saturday"
    And I click "Add Item"
    And I select "first Menu Item" to "Chicken"
    And I fill in "first Daily stock" with "10"
    And I click "Add Item"
    And I select "second Menu Item" to "Beef"
    And I fill in "second Daily stock" with "5"
    And I click "Update Menu" button
    Then I should see "Item 'Chicken' is included in overlapping menu 'Friday' and 'Beef' is included in overlapping menu 'Thursday'"




