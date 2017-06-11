Feature: Generate school room reports
  To use application resources
  As a system user
  I would like to generate a report by school room

  	Scenario: Generate report school room all
		Given I am logged in as coordinator
		And click on link 'Relatórios'
		And click on link 'Turmas' in 'Relatório'
		And I fill in 'relatorio' with 'Todas'
		When I press 'Gerar Relatório Todas as turmas' link
		

	Scenario: Generate report school room  allocation
		Given I am logged in as coordinator
		And click on link 'Relatórios'
		And click on link 'Turmas' in 'Relatório'
		And I fill in 'relatorio' with 'Alocadas'
		When I press 'Gerar Relatório de Turmas Alocadas' link
	

	Scenario: Generate report school room no allocation
		Given I am logged in as coordinator
		And click on link 'Relatórios'
		And click on link 'Turmas' in 'Relatório'
		And I fill in 'relatorio' with 'Não Alocadas'
		When I press 'Gerar Relatório de turmas não Alocadas' link
		
