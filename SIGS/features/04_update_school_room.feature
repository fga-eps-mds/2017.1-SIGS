Feature: Update school room
	To use application resources
	As a coordinator user
	I would like to update a new School room

	Scenario: change school room with valid attributes
		Given I am logged in as coordinator
		And click on link 'Meu Departamento'
		And click on edit first
		And I select '1' in 'discipline_id'
		And I check 'Engenharia Eletronica'
		And I fill in 'capacity' with '50'
		When I press 'Alterar' button
		Then notice message 'A turma foi alterada com sucesso'