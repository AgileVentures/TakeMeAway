Feature: As an admin
  In order to be able to use the application
  I would like to be able to access a admin interface when i visit the application


Scenario: Access the sign in page
  Given I am not logged in
  When I visit the site
  Then I should be on the "login" page