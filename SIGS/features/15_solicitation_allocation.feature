Feature: Solicitation an allocation to other department
  To use application resources
  As a coordinator
  I would like to create a new allocation solicitation

  Scenario: request allocation in allocation period without schedule
    Given I am logged in as coordinator 
    Given I am in the allocation period
    And click on link 'Alocar'
    When click in solicitation link
    Then expected 'Período de Alocação'
    And I fill justification
    When click on button 'Enviar'
    And I expect 'Selecione o horário que deseja'

  Scenario: request allocation in adjustment period
    Given I am logged in as coordinator
    And change date of allocation period
    And click on link 'Alocar'
    When click in solicitation link
    Then expected 'Período de Ajuste'
    And I fill justification

  Scenario: request allocation and see time options of all shifts
    Given I am logged in as coordinator
    And change date of allocation period
    And click on link 'Alocar'
    When click in solicitation link
    Then expected all periods available for allocation
