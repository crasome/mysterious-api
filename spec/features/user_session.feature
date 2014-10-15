@user_session @javascript
Feature: User session
  As user
  I want to manage my session
  So I can register and identify myself

  Scenario: Registration
    When I register
    Then my account should be created
     And I should be on login page

  Scenario: Login
    Given I am registered user
     When I login
     Then I should be logged in

  Scenario: Logout
    Given I am logged in
     When I logout
     Then I should be logged out
