@expenses
Feature: Expenses
  As user
  I want to track my expenses
  So I can view, edit and remove them

  Background:
    Given I am registered user
      And I login

  Scenario: A list of my expenses
    Given I have several expenses
     When I go to my expenses list
     Then I should see all my expenses

  Scenario: View an expense
     When I go to expense
     Then I should see it details

  Scenario: Add new expense
     When I add an expense
     Then I should see it in my expenses list

  Scenario: Delete an expense
    Given I have an expense
     When I delete it
     Then I should not see it in my expenses list

  Scenario: Edit an expense
    Given I have an expense
     When I modify it
     Then I should see modified expense in my expenses list
