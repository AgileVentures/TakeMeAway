Feature:
  As an Admin
  In order to be able to present my daily menu to customers
  I would like be able to access an interface for creating, populating, updating and deleting Menus

  Background:
    Given the following MenuItems exits:
      | name    | price |
      | Chicken | 20    |
      | Beef    | 30    |
    And I am logged in as admin

  Scenario: Create a menu
    Given I am on the "Menus" page
    And I click the "New Menu" link
    And I fill in "Title" with "Monday menu"
    Then show me the page


#  Scenario: Create menu category with menu items
#    When I go to the menu categories admin page
#    And I create a new menu category called 'Lunch'
#    And I add three menu items to menu category 'Lunch'
#    Then I should see menu category 'Lunch' with three items

#  Scenario: Create customer menu
#    When I go to the menu edit admin page
#    And I select menu category 'Lunch'
#    Then I select menu category 'Specials'
#    And I save the menu
#    And I go to the customer menu page
#    Then I should see three menu items displayed under the title 'Lunch'
#    And I should see two menu items displayed under the title 'Specials'
