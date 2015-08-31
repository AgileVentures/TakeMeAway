Feature: As an admin
  In order to deliver right orders to my clients
  I would like to access order information in the admin interface


  Background:
    Given the following users exist:
      | name    | email           | password | is_admin |
      | Admin   | admin@tma.org   | password | true     |
      | Client1 | client@tma.org  | password | false    |
      | Client2 | client2@tma.org | password | false    |

    And the following MenuItems exist:
      | id | name    | price |
      | 1  | Chicken | 20    |
      | 2  | Beef    | 30    |
      
    And the following Menus exist:
      | id | title    | start_date | end_date   |
      | 1  | Today    | today      | today      |
      | 2  | ThisWeek | this_week  | this_week  |
      | 3  | NextWeek | next_week  | next_week  |

    And I am logged in as admin

  Scenario: View index
    Given the following Orders exist:
    | order[id]  | user[user] | order[pickup_time] | order[order_time] | menu_item[name] | menu[id] |
    | 1          | Client1    | 2015-01-01         | 2015-01-01        | Chicken         | 1        |
    | 2          | Client2    | 2015-01-02         | 2015-01-02        | Beef            | 2        |
    And I am on the "Orders" page
    And I click the "All" link
    Then I should see an index of "Orders"
    And I should see 2 record rows

  Scenario: View existing Order
    Given the following Orders exist:
    | order[id]  | user[user] | order[pickup_time] | order[order_time] | menu_item[name] | menu[id] |
    | 1          | Client1    | 2015-01-01         | 2015-01-01        | Chicken         | 1        |
    | 2          | Client2    | 2015-01-02         | 2015-01-02        | Beef            | 2        |
    And I am on the "Orders" page
    And I click the "All" link
    When I click the "view" link for "Order #1"
    Then I should be on the view page for Order "Order #1"
    And I should see "Order #1"

  Scenario: Toggle status
    Given the following Orders exist:
    | order[id]  | user[user] | order[pickup_time] | order[order_time] | menu_item[name] | menu[id] |
    | 1          | Client1    | 2015-01-01         | 2015-01-01        | Chicken         | 1        |
    | 2          | Client2    | 2015-01-02         | 2015-01-02        | Beef            | 2        |
    And I am on the "Orders" page
    And I click the "All" link
    When I click the "Change status" link for "Order #1"
    Then I should be on the "Orders" page
    And I should see "Changed status to 'processed'"
    And I click the "All" link
    When I click the "Change status" link for "Order #1"
    Then I should see "Changed status to 'pending'"

  Scenario: Cancel order
    Given the following Orders exist:
    | order[id]  | user[user] | order[pickup_time] | order[order_time] | menu_item[name] | menu[id] |
    | 1          | Client1    | 2015-01-01         | 2015-01-01        | Chicken         | 1        |
    | 2          | Client2    | 2015-01-02         | 2015-01-02        | Beef            | 2        |
    And I am on the "Orders" page
    And I click the "All" link
    When I click the "Cancel" link for "Order #2"
    Then I should be on the "Orders" page
    And I should see "Canceled order"
    And I click the "Canceled" link
    Then I should see 1 record rows
    And I should see "Order #2"
    And I should not see "Order #1"
    
  @javascript
  Scenario: Create order
    Given "Chicken" has been added as a MenuItem to "Today"
    Given "Beef" has been added as a MenuItem to "ThisWeek"
    And I am on the "Orders" page
    When I click the "New Order" link
    Then I should be on the "New Order" page
    And I select "Client" to "Client1"
    And I select the time "tomorrow 10:00" in datepicker for Order Order Time
    And I select the time "tomorrow 13:00" in datepicker for Order Pickup Time
    Then I click "Add Item"
    And I should not be able to select "NextWeek"
    And I should be able to select "Today"
    And I should be able to select "ThisWeek"
    And I select "first Order Menu" to "Today"
    And I should be able to select "Chicken"
    And I should not be able to select "Beef"
    And I select "first Order Item" to "Chicken"
    And I fill in "first Order Item quantity" with "1"
    Then I click "Add Item"
    And I select "second Order Menu" to "ThisWeek"
    And I select "second Order Item" to "Beef"
    And I fill in "second Order Item quantity" with "1"
    And I click "Create Order" button
    And I should see "Order was successfully created"
    And I should see "Chicken"
    And I should see "Beef"
    
#  @javascript
#  Scenario: Edit order
#    When I click the "Edit" link for "Order #2"
#    Then I should be on the edit page for Order "Order #2"
#    And I select "Order Item" to "Chicken"
#    And I fill in "Quantity" with "2"
#    And I click "Create Order item" button
#    Then I should be on the view page for Order "Oreder #2"
#    And I should see "Chicken"
#    And I should see "2"
    
    



