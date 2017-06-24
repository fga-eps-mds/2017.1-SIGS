Feature: Filter rooms
	To use application resources
	As a system user
	I would like to filter rooms

	Scenario: Filter by name
  	Given I am logged in as assistant administrative
  	When click on link 'Salas'
  	And I fill in 'name' with 'S10'
  	When I press 'Pesquisar' button
  	Then the 'Salas' page should load with message 'S10'

	Scenario: Filter by code
   Given I am logged in as assistant administrative
   When click on link 'Salas'
   And I fill in 'code' with '987653'
   When I press 'Pesquisar' button
   Then the 'Salas' page should load with message '987653'

 	Scenario: Filter by capacity
   Given I am logged in as assistant administrative
   When click on link 'Salas'
   And I fill in 'capacity' with '50'
   When I press 'Pesquisar' button
   Then the 'Salas' page should load with message '124325'

  Scenario: Filter by Build
    Given I am logged in as assistant administrative
    When click on link 'Salas'
    And I select 'Pavilhão João Calmon'
    Then the 'Salas' page should load with message 'Pavilhão João Calmon'

	Scenario: Filter by Wings
    Given I am logged in as assistant administrative
    When click on link 'Salas'
    And I select 'Norte'
    Then the 'Salas' page should load with rooms in 'Norte' wing

	Scenario: Filter by All
		Given I am logged in as assistant administrative
		When click on link 'Salas'
		And I fill in 'name' with 'S10'
		And I fill in 'code' with '124325'
		And I fill in 'capacity' with '50'
		And I select 'Pavilhão Anísio Teixeira'
		Then the 'Salas' page should load with the result of the search
