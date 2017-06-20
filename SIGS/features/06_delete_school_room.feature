Feature: Delete school room
	To use application resources
	As a coordinator user
	I would like to delete a new existing school room

	Scenario: delete school room with
		Given I am logged in as Caio, an coordinator
		And click on link 'Alocar'
		And click on link 'Criar Nova Turma'
		And I choose SchoolRoom with name 'D'
