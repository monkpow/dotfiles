# features/myFeature.feature

Feature: Example feature
  As a user of cucumber.js
  I want to have documentation on cucumber
  So that I can concentrate on building awesome applications

  Scenario: Reading documentation
    Given I am on my local node server 
    Then I should see "Usage" as the page title

  Scenario: Unit testing a javascript Object
    Given I have loaded a javascript file
    Then I should be able to manipulate the object

  Scenario: I can visit a fixture
    Given I have a javascript fixture
    Then node should load and return it

