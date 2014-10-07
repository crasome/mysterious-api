@expences
Feature: Expences
  As user
  I want to track my expences
  So I can view, edit and remove them

  Background:
    Given I am registered user
      And I login

  Scenario: A list of my expences
    Given I have several expences
     When I go to my expences list
     Then I should see all my expences

  Scenario: View an expence
     When I go to expence
     Then I should see it details

  Scenario: Add new expence
     When I add an expence
     Then I should see it in my expences list

  Scenario: Delete an expence
    Given I have an expence
     When I delete it
     Then I should not see it in my expences list

  Scenario: Edit an expence
    Given I have an expence
     When I modify it
     Then I should see modified expence in my expences list
