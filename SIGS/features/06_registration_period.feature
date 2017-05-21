Feature: Registration Period
	To use application resources
	As a system user
	I would like to registrate a period

	Scenario: Show periods of halfyear
		Given I am logged in as assistant administrative
		When click on link 'Período'
		Then the 'Período' page should load with periods information

	Scenario: Edit period 'Alocação' with valid
		Given I am logged in as assistant administrative
		When click on link 'Período'
		And I press 'Icon edit' button
		And I fill in 'initial_date' with '2018-01-15T06:00:00'
		And I fill in 'final_date' with '2018-02-10T18:00:00'
		When I press 'Salvar' button
		Then the 'Período' page should load with 'Dados do período atualizados com sucesso'

	Scenario: Edit period 'Alocação' with invalid
		Given I am logged in as assistant administrative
		When click on link 'Período'
		And I press 'Icon edit' button
		And I fill in 'initial_date' with '2018-10-15T00:00:00'
		And I fill in 'final_date' with '2018-03-10T18:00:00'
		When I press 'Salvar' button
		Then the 'Editando Período' page should load with 'Dados do período não foram atualizados'
		And the 'Editando Período' page should load with 'A Data Final deve ser depois da Data de Início'
