Feature: As an admin
  In order to be able to use the application
  I would like to be able to access a admin interface when i visit the application

  Background:
    Given the following users exist:
      | name     | email          | password | is_admin |
      | Admin    | admin@tma.org  | password | true     |
      | Client 1 | client@tma.org | password | false    |


  Scenario: Access the sign in page
    Given I am not logged in
    When I visit the site
    Then I should be on the "login" page

  Scenario: Login as admin 
    Given I am on the "login" page
    And I fill in "Email" with "admin@tma.org"
    And I fill in "Password" with "password"
    And I click "Login" button
    Then I should be on the "ActiveAdmin root" page
    When I click the "Dashboard" link
    And I should see link "Clients"
    And I should see link "Admins"

  Scenario: Login as Client
    Given I am on the "login" page
    And I fill in "Email" with "client@tma.org"
    And I fill in "Password" with "password"
    And I click "Login" button
    Then I should be on the "ActiveAdmin root" page
    When I click the "Dashboard" link
    And I should not see link "Clients"
    And I should not see link "Admins"

