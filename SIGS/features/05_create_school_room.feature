Feature: Create school room
	To use application resources
	As a coordinator user
	I would like to create a new School room

	Scenario: create school room with valid attributes
		Given I am logged in as coordinator
		And click on link 'Turmas'
		And I select '' in 'discipline_id'
		And I fill in 'name' with 'D'
		When I press 'Salvar' button
		Then notice message 'create'
