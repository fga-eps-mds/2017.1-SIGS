Feature: Filter rooms
	To use application resources
	As a system user
	I would like to filter rooms

	Scenario: Filter by name
        Given I am logged in as asssistant administrative
        When click on link 'Salas'
        And I fill in 'name' with 'S10'
        When I press 'Submit' button
        Then the 'Salas' page should load with message 'S10'

	Scenario: Filter by code
        Given I am logged in as asssistant administrative
        When click on link 'Salas'
        And I fill in 'code' with '987653'
        When I press 'Submit' button
        Then the 'Salas' page should load with message '987653'

 	Scenario: Filter by capacity
        Given I am logged in as asssistant administrative
        When click on link 'Salas'
        And I fill in 'capacity' with '50'
        When I press 'Submit' button
        Then the 'Salas' page should load with message '124325'

    Scenario: Filter by Build
        Given I am logged in as asssistant administrative
        When click on link 'Salas'
        And I select 'Pavilhão João Calmon'
        Then the 'Salas' page should load with message 'Pavilhão João Calmon'

