Feature: Manager User
  To use application resources
  As a system user
  I would like to manager a user account

  Scenario: Change name and password both valid of a user
    Given I am logged in as assistant administrative
    When click on link 'Minha Conta'
    And I fill in 'password-user' with '654321'
    And I fill in 'confirm_password' with '654321'
    When I press 'Salvar' button
    Then the 'Minha Conta' page should load with notice message 'Dados atualizados com sucesso'

  Scenario: Change name and password both invalid of a user
    Given I am logged in as assistant administrative
    When click on link 'Minha Conta'
    And I fill in 'password-user' with '654'
    And I fill in 'confirm_password' with '654'
    When I press 'Salvar' button
    Then the 'Minha Conta' page should load with notice message 'Dados não foram atualizados'

  Scenario: Delete a only account of a administrative assistant
    Given I am logged in as assistant administrative
    When click on link 'Minha Conta'
    When I press 'Excluir Conta' button
    Then the initial page should load with notice message 'Não é possível excluir o único Assistente Administrativo'

  Scenario: Delete another account of a user
    Given I am logged in as assistant administrative
    And I delete all the allocations of this user
    And click on link 'Usuários'
		And click on link 'Usuários Registrados'
    When I press 'Delete' button
    Then the 'Usuarios Registrados' page should load with notice message 'Usuário excluído com sucesso'

  Scenario: None registrate users to administer
    Given I am logged in as assistant administrative
    And I delete all the allocations of this user
    When I delete anothers registration users
    And click on link 'Usuários'
    And click on link 'Usuários Registrados'
    Then the 'Usuarios Registrados' page should load with notice message 'Não há nenhum usuário registrado no momento.'
