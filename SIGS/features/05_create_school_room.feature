Feature: Create school room
	To use application resources
	As a coordinator user
	I would like to create a new School room

	Scenario: create school room with valid attributes
		Given I am logged in as coordinator
		And click on link 'Nova Turma'
		And I select '1' in 'discipline_id'
		And I fill in 'name' with 'D'
		And I fill in 'capacity' with '50'
		When I press 'Salvar' button
		Then notice message 'Turma criada'

	Scenario: create school room with valid attributes adding category and course
		Given I am logged in as coordinator
		And click on link 'Nova Turma'
		And I select '1' in 'discipline_id'
		And I check 'Engenharia Eletronica'
		And I check 'Retroprojetor'
		And I fill in 'name' with 'D'
		And I fill in 'capacity' with '50'
		When I press 'Salvar' button
		Then notice message 'Turma criada'

	Scenario: create school room with null name attributes
		Given I am logged in as coordinator
		And click on link 'Nova Turma'
		And I select '1' in 'discipline_id'
		And I fill in 'capacity' with '50'
		When I press 'Salvar' button
		Then notice message 'Indique o nome da turma'


	Scenario: create school room with existent name attributes
		Given I am logged in as coordinator
		And click on link 'Nova Turma'
		And I select '1' in 'discipline_id'
		And I fill in 'name' with 'A'
		And I fill in 'capacity' with '50'
		When I press 'Salvar' button
		Then notice message 'Turma com nome já cadastrado'

	Scenario: create school room with invalid capacity
		Given I am logged in as coordinator
		And click on link 'Nova Turma'
		And I select '1' in 'discipline_id'
		And I fill in 'name' with 'D'
		And I fill in 'capacity' with '0'
		When I press 'Salvar' button
		Then notice message 'Capacidade Inválida'
