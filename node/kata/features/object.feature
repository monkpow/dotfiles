# features/myFeature.feature

Feature: basic object test

  Scenario: Unit testing a javascript Object
    Given I have required scripts/nikTest.js
    Then I should be able to access nikTest

  Scenario: I can visit a fixture
    Given I have a javascript fixture
    Then node should load and return it

    Scenario: I have instantiated doxie
    Given I have asked for an instance of doxie
    Then the returned object should respond to simple_member
    Then the returned object should respond to simple_method

