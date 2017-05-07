Feature: Room Edit and show
  To use application resources
  As a system user
  I would like to edit and show a room

  Scenario: Change code, name and capacity both valid of room
    Given I am logged in as asssistant administrative
    When click on link 'Salas'
    And I press 'Icon edit' button
    And I fill in 'code' with '45632'
    And I fill in 'name' with 'I10'
    And I fill in 'capacity' with '60'
    When I press 'Salvar' button
    Then the 'Salas' page should load with notice message 'Dados da sala atualizados com sucesso'

  Scenario: Change code, name and capacity both empty of room
    Given I am logged in as asssistant administrative
    When click on link 'Salas'
    And I press 'Icon edit' button
    And I fill in 'code' with ''
    And I fill in 'name' with ''
    And I fill in 'capacity' with ''
    When I press 'Salvar' button
    Then the 'Salas' page should load with notice message 'Dados não foram atualizados'


  Scenario: Change code, name and capacity both invalid of room
    Given I am logged in as asssistant administrative
    When click on link 'Salas'
    And I press 'Icon edit' button
    And I fill in 'code' with '45632'
    And I fill in 'name' with 'a'
    And I fill in 'capacity' with '2'
    When I press 'Salvar' button
    Then the 'Salas' page should load with notice message 'Dados não foram atualizados'

  Scenario: No one room to edit
    Given I am logged in as asssistant administrative
    When I delete all rooms
    When click on link 'Salas'
    Then the 'Salas' page should load with notice message 'Não há salas registradas no momento.'

  Scenario: Show the details of a room
    Given I am logged in as asssistant administrative
    When click on link 'Salas'
    And I press 'Icon view' button
    Then the 'Visualizar Sala' page should load with informations of that room
