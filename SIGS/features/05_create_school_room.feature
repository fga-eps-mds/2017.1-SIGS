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
		Then notice message 'Turma não pode ser vazia'


	Scenario: create school room with existent name attributes
		Given I am logged in as coordinator
		And click on link 'Nova Turma'
		And I select '1' in 'discipline_id'
		And I fill in 'name' with 'A'
		And I fill in 'capacity' with '50'
		When I press 'Salvar' button
		Then notice message 'Turma com nome já cadastrado'

	Scenario: create school room with null capacity
		Given I am logged in as coordinator
		And click on link 'Nova Turma'
		And I select '1' in 'discipline_id'
		And I fill in 'name' with 'D'
		And I fill in 'capacity' with null
		When I press 'Salvar' button
		Then notice message 'Capacidade não pode ser vazia'

	Scenario: create school room with lower capacity
		Given I am logged in as coordinator
		And click on link 'Nova Turma'
		And I select '1' in 'discipline_id'
		And I fill in 'name' with 'D'
		And I fill in 'capacity' with '1'
		When I press 'Salvar' button
		Then notice message 'A capacidade mínima é 5 vagas'


	Scenario: create school room with high capacity
		Given I am logged in as coordinator
		And click on link 'Nova Turma'
		And I select '1' in 'discipline_id'
		And I fill in 'name' with 'D'
		And I fill in 'capacity' with '800'
		When I press 'Salvar' button
		Then notice message 'A capacidade máxima é 500 vagas'
