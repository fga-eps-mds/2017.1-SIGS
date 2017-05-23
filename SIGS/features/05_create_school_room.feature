Feature: Create school room
	To use application resources
	As a coordinator user
	I would like to create a new School room

	Scenario: create school room with valid attributes
		Given I am logged in as coordinator
		And click on link 'Turmas'
		And I click on link 'Criar Turma'
		And I select '' in 'discipline_id'
		And I fill in 'name' with 'D'
		And I fill in 'type' with 'Engenharia de Software'
		When I press 'Salvar' button
		Then notice message 'create'
		