Feature: Create school room
	To use application resources
	As a coordinator user
	I would like to create a new School room

	Scenario: create school room with valid attributes
		Given I am logged in as coordinator
		And click on link 'Alocar'
		And click on link 'Criar Nova Turma'
		And I select '1' in 'discipline_id'
		And I search 10 in courses
		And I fill in 'name' with 'DD'
		And I fill in 'vacancies' with '50'

	Scenario: create school room with valid attributes adding category
		Given I am logged in as coordinator
		And click on link 'Alocar'
		And click on link 'Criar Nova Turma'
		And I select '1' in 'discipline_id'
		And I search 10 in courses
		And I check 'Retroprojetor'
		And I fill in 'name' with 'DD'
		And I fill in 'vacancies' with '50'

	Scenario: create school room with lower vacancies
		Given I am logged in as coordinator
		And click on link 'Alocar'
		And click on link 'Criar Nova Turma'
		And I select '1' in 'discipline_id'
		And I search 10 in courses
		And I fill in 'name' with 'DD'
		And I fill in 'vacancies' with '1'
		When I press 'Salvar' button
		Then notice message 'A capacidade mínima é 5 vagas'


	Scenario: create school room with high vacancies
		Given I am logged in as coordinator
		And click on link 'Alocar'
		And click on link 'Criar Nova Turma'
		And I select '1' in 'discipline_id'
		And I search 10 in courses
		And I fill in 'name' with 'DD'
		And I fill in 'vacancies' with '800'
		When I press 'Salvar' button
		Then notice message 'A capacidade máxima é 500 vagas'
