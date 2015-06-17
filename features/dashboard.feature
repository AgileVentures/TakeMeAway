Feature: As an admin
  In order to be able to use the application
  I would like to be able to access a admin interface when i visit the application

  Background:
    Given the following users exist:
      | name     | email          | password | is_admin | receive_notifications | order_acknowledge_email|
      | Admin    | admin@tma.org  | password | true     | true                  | true                   |
      | Client 1 | client@tma.org | password | false    | false                 | false                  |


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
    
  Scenario: Change password
    Given I am logged in as admin
    And I am on the "Admins" page
    And I click the "Edit" link for "Admin"
    Then I should be on the edit page for user "Admin"
    And I fill in "user_password" with "new_password"
    And I fill in "user_password_confirmation" with "new_password"
    And I click "Update User" button
    Then I should be on the view page for user "Admin"
    And I should see "User was successfully updated."
    
  Scenario: Change email settings
    Given I am logged in as admin
    And I am on the "Admins" page
    And I click the "Edit" link for "Admin"
    Then I should be on the edit page for user "Admin"
    And I uncheck "Receive notifications"
    And I uncheck "Use this email address to send order acknowledgement to the customer"
    And I click "Update User" button
    Then I should be on the view page for user "Admin"
    And I should see "User was successfully updated."
    And I should see "Receive Notifications false"
    And I should see "Order Acknowledge Email false"

  Scenario: Login as Client
    Given I am on the "login" page
    And I fill in "Email" with "client@tma.org"
    And I fill in "Password" with "password"
    And I click "Login" button
    Then I should be on the "ActiveAdmin root" page
    When I click the "Dashboard" link
    And I should not see link "Clients"
    And I should not see link "Admins"

