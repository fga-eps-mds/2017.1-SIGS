Feature: Realize Allocation, js: true do
  To use application resources
  As a system user
  I would like to realize allocation

  Scenario: realize one valid allocation
    Given I am logged in as coordinator
    And click on link 'Alocar'
    And click on button 'Alocar' to 'Cálculo 1'
    # And click on checkbox 'check_Quinta_18'
    # And I press 'Salvar' button
    # Then the 'Alocação' page should load with notice message 'Alocação feita com sucesso'
