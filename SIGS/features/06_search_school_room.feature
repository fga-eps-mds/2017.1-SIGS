Feature: Index School Rooms
  To use application resources
  As a coordinator user
  I would like to search school rooms

  Scenario: search existing school room
		Given I am logged in as coordinator
		And click on link 'Meu Departamento'
		And I fill in 'search' with 'Cal'
		When I press searchButton button
    And print the result search

  Scenario: search not existing school room
		Given I am logged in as coordinator
		And click on link 'Meu Departamento'
		And I fill in 'search' with 'Art'
		When I press searchButton button
    Then notice message 'Nenhuma turma encontrada'

  Scenario: search existing school room in result page
    Given I am logged in as coordinator
    And click on link 'Meu Departamento'
    And I fill in 'search' with 'Cal'
    When I press searchButton button
    And print the result search
    And I fill in 'search' with 'Cal'
    When I press searchButton button
    And print the result search
