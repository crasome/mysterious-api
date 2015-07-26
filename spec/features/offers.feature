@offers @javascript @vcr
Feature: Offers
  As API consumer
  I want to see all available offers
  So I can show them to application users

  Scenario: List offers
    Given I am on the offers page
    When I request the offers
    Then I should see the offers listed
