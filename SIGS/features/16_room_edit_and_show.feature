Feature: Room Edit and show
  To use application resources
  As a system user
  I would like to edit and show a room

  Scenario: Change code, name and capacity both valid of room
    Given I am logged in as asssistant administrative
    When click on link 'Salas'
    And I press 'Icon edit' button
    And I fill in 'code' with '987655'
    And I fill in 'name' with 'S9'
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
    And the 'Alterar Sala' page should load with the errors messages
    Then the 'Alterar Sala' page should load with notice message 'Dados não foram atualizados'


  Scenario: Change code, name both invalids and capacity less than 5 of room
    Given I am logged in as asssistant administrative
    When click on link 'Salas'
    And I press 'Icon edit' button
    And I fill in 'code' with '987655'
    And I fill in 'name' with 'a'
    And I fill in 'capacity' with '2'
    When I press 'Salvar' button
    And the 'Alterar Sala' page should load with errors messages of empty fields
    Then the 'Alterar Sala' page should load with notice message 'Dados não foram atualizados'

  Scenario: Change code, name both invalids and capacity greater than 500 of room
    Given I am logged in as asssistant administrative
    When click on link 'Salas'
    And I press 'Icon edit' button
    And I fill in 'code' with '987655'
    And I fill in 'name' with 'S9'
    And I fill in 'capacity' with '900'
    When I press 'Salvar' button
    And the 'Alterar Sala' page should load with a error message of capacity field
    Then the 'Alterar Sala' page should load with notice message 'Dados não foram atualizados'

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
