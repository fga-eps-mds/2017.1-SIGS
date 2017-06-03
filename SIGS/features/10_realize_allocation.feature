Feature: Realize Allocation
  To use application resources
  As a system user
  I would like to realize allocation

  Scenario: realize one valid allocation
    Given I am logged in as coordinator
    And click on link 'Alocações'
    And click on link 'Graduação'
    And select Turma 'A' of Turma droplist
    And click on button 'Segunda'
    And select Sala 'S10' of Sala droplist
    And I fill in 'allocation-start_time' with '10:00'
    And I fill in 'allocation-final_time' with '12:00'
    When I press 'Salvar' button of 'Segunda'
    Then the 'Alocação' page should load with notice message 'Alocação feita com sucesso'

  Scenario: realize three valid allocations in different days
    Given I am logged in as coordinator
    And click on link 'Alocações'
    And click on link 'Graduação'
    And select Turma 'A' of Turma droplist
    And click on button 'Segunda'
    And select Sala 'S10' of Sala droplist
    And I fill in 'allocation-start_time' with '10:00'
    And I fill in 'allocation-final_time' with '12:00'
    When I press 'Salvar' button of 'Segunda'
    Then the 'Alocação' page should load with notice message 'Alocação feita com sucesso'

  Scenario: realize one invalid allocation with non-vacant schedule allocation
    Given I allocated  school room 'A' on room 'S10' at '10:00' until '12:00'
    Given I am logged in as coordinator
    And click on link 'Alocações'
    And click on link 'Graduação'
    And select Turma 'A' of Turma droplist
    And click on button 'Segunda'
    And select Sala 'S10' of Sala droplist
    And I fill in 'allocation-start_time' with '10:00'
    And I fill in 'allocation-final_time' with '12:00'
    When I press 'Salvar' button of 'Segunda'
    Then the 'Alocação' page should load with notice message 'Alocação com horário não vago ou capacidade da sala cheia'

  Scenario: realize one invalid allocation with invalid schedule
    Given I am logged in as coordinator
    And click on link 'Alocações'
    And click on link 'Graduação'
    And select Turma 'A' of Turma droplist
    And click on button 'Segunda'
    And select Sala 'S10' of Sala droplist
    And I fill in 'allocation-start_time' with '12:00'
    And I fill in 'allocation-final_time' with '10:00'
    When I press 'Salvar' button of 'Segunda'
    Then the 'Alocação' page should load with notice message 'Horário inválido'

  Scenario: realize another allocation in the same room with another school room, capacity valid
    Given I allocated  school room 'A' on room 'S8' at '10:00' until '12:00'
    Given I am logged in as coordinator
    And click on link 'Alocações'
    And click on link 'Graduação'
    And select Turma 'D' of Turma droplist
    And click on button 'Segunda'
    And select Sala 'S8' of Sala droplist
    And I fill in 'allocation-start_time' with '10:00'
    And I fill in 'allocation-final_time' with '12:00'
    When I press 'Salvar' button of 'Segunda'
    Then the 'Alocação' page should load with notice message 'Alocação feita com sucesso'

  Scenario: realize another allocation in the same room with another school room, capacity invalid
    Given I allocated  school room 'A' on room 'S10' at '10:00' until '12:00'
    Given I am logged in as coordinator
    And click on link 'Alocações'
    And click on link 'Graduação'
    And select Turma 'D' of Turma droplist
    And click on button 'Segunda'
    And select Sala 'S10' of Sala droplist
    And I fill in 'allocation-start_time' with '10:00'
    And I fill in 'allocation-final_time' with '12:00'
    When I press 'Salvar' button of 'Segunda'
    Then the 'Alocação' page should load with notice message 'Alocação com horário não vago ou capacidade da sala cheia'
