@javascript
Feature: It makes sense to use cucumber as a javascript tool

Scenario: A page is visited, and has some javascript on it

  When I go to home page 
  Then I should see a hello world object
