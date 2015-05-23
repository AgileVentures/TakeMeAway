Feature: As an admin
  In order to deliver right orders to my clients
  I would like to access order information in the admin interface


  Background:
    Given the following users exist:
      | name     | email          | password | is_admin |
      | Admin    | admin@tma.org  | password | true     |
      | Client 1 | client@tma.org | password | false    |

    And the following MenuItems exits:
      | id | name    | price |
      | 1  | Chicken | 20    |
      | 2  | Beef    | 30    |

    And the following Orders exits:
      | user[user] | order[pickup_time] | order[order_time] | menu_items[menu_item_id] |
      | Client 1   | 2015-01-01         | 2015-01-01        | 1                        |
      | Client 1   | 2015-01-02         | 2015-01-02        | 2                        |

    And I am logged in as admin
    And I am on the "Orders" page
    And I click the "All" link

  Scenario: View index
    Then I should see an index of "Orders"
    And I should see 2 record rows



