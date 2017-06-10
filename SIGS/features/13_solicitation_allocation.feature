Feature: Solicitation an allocation to other department
  To use application resources
  As a coordinator
  I would like to create a new allocation solicitation

  Scenario: open page of solicitation allocation in allocation period
    Given I am logged in as coordinator
	And click on link 'Meu Departamento'
	And change date of allocation period
	When click in solicitation link
	Then expected 'Cálculo 1'