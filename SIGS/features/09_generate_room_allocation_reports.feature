Feature: Generate room allocation reports
  To use application resources
  As a system user
  I would like to generate a report by room

  Scenario: Generate report single room
		Given I am logged in as coordinator
		And click on link 'Relatórios'
		And click on link 'Salas' in 'Relatório'
		And select in 'Departamento' option 'Engenharia'
		And select in 'Código da sala' option 'S10'
		When I press 'Gerar' button
		Then generate a PDF

	Scenario: Generate report all rooms
		Given I am logged in as coordinator
		And click on link 'Relatórios'
		And click on link 'Salas' in 'Relatório'
		And select in 'Departamento' option 'Engenharia'
		And check 'Todas as salas'
		When I press 'Gerar' button
		Then generate a PDF
