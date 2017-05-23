Feature: Delete school room
	To use application resources
	As a coordinator user
	I would like to delete a new existing school room

	Scenario: delete school room with
		Given I am logged in as Caio, an coordinator
		And click on link 'Turmas'
		And I choose SchoolRoom with name 'D'
		And I click on view icon
		When I press the "Excluir Turma" button
		Then notice message 'A turma foi excluída com sucesso'
		