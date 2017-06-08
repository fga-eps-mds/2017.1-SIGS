Feature: Update school room
	To use application resources
	As a coordinator user
	I would like to update a new School room

	Scenario: change school room with valid attributes
		Given I am logged in as coordinator
		And click on link 'Meu Departamento'
		And click on edit first
		And I select '1' in 'discipline_id'
		And I fill in 'vacancies' with '50'
		When I press 'Alterar' button
		Then notice message 'A turma foi alterada com sucesso'

	Scenario: change school room with low vacancies
		Given I am logged in as coordinator
		And click on link 'Meu Departamento'
		And click on edit first
		And I select '1' in 'discipline_id'
		And I fill in 'vacancies' with '1'
		When I press 'Alterar' button
		Then notice message 'A capacidade mínima é 5 vagas'

	Scenario: change school room with high vacancies
		Given I am logged in as coordinator
		And click on link 'Meu Departamento'
		And click on edit first
		And I select '1' in 'discipline_id'
		And I fill in 'vacancies' with '800'
		When I press 'Alterar' button
		Then notice message 'A capacidade máxima é 500 vagas'

	Scenario: change school room with null vacancies
		Given I am logged in as coordinator
		And click on link 'Meu Departamento'
		And click on edit first
		And I select '1' in 'discipline_id'
		And I fill in 'vacancies' with null
		When I press 'Alterar' button
		Then notice message 'Capacidade não pode ser vazia'

	Scenario: change school room with zero courses
		Given I am logged in as coordinator
		And click on link 'Meu Departamento'
		And click on edit first
		And I select '1' in 'discipline_id'
		And I fill in 'vacancies' with '50'
		And I uncheck 'Engenharia Automotiva'
		And I uncheck 'Artes Visuais'
		When I press 'Alterar' button
		Then notice message 'Turma deve haver pelo menos um curso'

	Scenario: change school room with coures in differents periods
		Given I am logged in as coordinator
		And click on link 'Meu Departamento'
		And click on edit first
		And I select '1' in 'discipline_id'
		And I check 'Engenharia Eletronica'
		And I check 'Engenharia Automotiva'
		And I fill in 'vacancies' with '50'
		When I press 'Alterar' button
		Then notice message 'Cursos devem ser do mesmo período'
