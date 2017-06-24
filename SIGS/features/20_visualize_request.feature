Feature: Visualize a request
  To use application resources
  As a user
  I would like to view a request

  Scenario: Load the request index page
      Given I am logged in as coordinator
      And click on link 'Solicitações'
      Then request index page should be loaded
