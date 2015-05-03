Feature:
  As an Admin
  In order to be able to present my daily menu to customers
  I would like be able to access an interface for creating, populating, updating and deleting Menus

  Background:
    Given the following Menus exits:
      | title   | start_date | end_date   |
      | Monday  | 2015-01-01 | 2015-01-05 |
      | Tuesday | 2015-01-02 | 2015-01-11 |
    And I am logged in as admin
    And I am on the "Menus" page

  Scenario: View index
    Then I should see an index of "Menus"
    And I should see 2 record rows

  @javascript
  Scenario: Create a menu
    When I click the "New Menu" link
    And I fill in "Title" with "Monday menu"
    #And I focus on input field with id "Menu Start Date"
    And I select the date "2015-05-08" in datepicker for Menu Start Date
    And I focus on input field with id "Menu End Date"
    And I select the date "2015-05-08" in datepicker for Menu End Date
    And I click "Create Menu" button
    Then I should be on the view page for Menu "Monday menu"
    And I should see "Menu was successfully created"

  @javascript
  Scenario: Edit existing menu
    When I click the "edit" link for "Monday"
    And I fill in "Title" with "Tuesday"
    And I focus on input field with id "Menu Start Date"
    And I select the date "2015-05-08" in datepicker for Menu Start Date
    And I focus on input field with id "Menu End Date"
    And I select the date "2015-05-08" in datepicker for Menu End Date
    And I click "Update Menu" button
    Then I should be on the view page for Menu "Tuesday menu"
    And I should see "Menu was successfully updated"

  Scenario: View existing MenuItem
    When I click the "view" link for "Monday"
    Then I should be on the view page for Menu "Monday"
    And I should see "Monday"
    And I should see "January 01, 2015"
    And I should see "January 05, 2015"

  Scenario: Delete exiting MenuItem
    When I click the "delete" link for "Tuesday"
    Then I should see an index of "Menus"
    And I should see "Menu was successfully destroyed."
    And I should see 1 record rows

