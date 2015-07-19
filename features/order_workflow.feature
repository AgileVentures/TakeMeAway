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
      | id | title   | start_date | end_date   |
      | 1  | Monday  | 2015-01-01 | today      |
      | 2  | Tuesday | 2015-01-02 | 2015-01-11 |

    And the following Orders exist:
      | order[id] | user[user] | order[pickup_time] | order[order_time] | menu_item[name] | menu[id] |
      | 1         | Client1    | 2015-01-01         | 2015-01-01        | Monday          | 1        |
      | 2         | Client2    | 2015-01-02         | 2015-01-02        | Tuesday         | 2        |

    And I am logged in as admin
    And I am on the "Orders" page
    And I click the "All" link

  Scenario: View index
    Then I should see an index of "Orders"
    And I should see 2 record rows

  Scenario: View existing Order
    When I click the "view" link for "Order #1"
    Then I should be on the view page for Order "Order #1"
    And I should see "Order #1"

  Scenario: Toggle status
    When I click the "Change status" link for "Order #1"
    Then I should be on the "Orders" page
    And I should see "Changed status to 'processed'"
    And I click the "All" link
    When I click the "Change status" link for "Order #1"
    Then I should see "Changed status to 'pending'"

  Scenario: Cancel order
    When I click the "Cancel" link for "Order #2"
    Then I should be on the "Orders" page
    And I should see "Canceled order"
    And I click the "Canceled" link
    Then I should see 1 record rows
    And I should see "Order #2"
    And I should not see "Order #1"
    
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
    
    



