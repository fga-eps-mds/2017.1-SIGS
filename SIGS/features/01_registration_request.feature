Feature: Registration Request
	To use application resources
	As a visitor user
	I would like to request a registration

	Scenario: Request registration of a user with valid attributes
		Given I am on the log in page
		When click on button 'Solicitar Cadastro'
		And I fill in 'name' with 'gesiel freitas'
		And I fill in 'cpf' with '02919147307'
		And I fill in 'registration' with '2244537'
		And I fill in 'password-user' with '123456'
		And I fill in 'confirm_password' with '123456'
		And I fill in 'email' with 'gesiel@unb.br'
		And I fill in 'type' with 'administrative_assistant'
		When I press 'Enviar' button
		Then the initial page should load with notice message 'Solicitação de cadastro efetuado com sucesso!'

  Scenario: Request registration of a user with invalid name
    Given I am on the log in page
    When click on button 'Solicitar Cadastro'
    And I fill in 'name' with 'Ana'
    And I fill in 'cpf' with '02919147307'
    And I fill in 'registration' with '2244537'
    And I fill in 'password-user' with '123456'
    And I fill in 'confirm_password' with '123456'
    And I fill in 'email' with 'gesiel@unb.br'
    And I fill in 'type' with 'coordinator'
    When I press 'Enviar' button
    Then the initial page should load with notice message 'O Nome deve ter no mínimo 7 caracteres'

  Scenario: Request registration of a user with invalid cpf
    Given I am on the log in page
    When click on button 'Solicitar Cadastro'
    And I fill in 'name' with 'gesiel freitas'
    And I fill in 'cpf' with '1234'
    And I fill in 'registration' with '2244537'
    And I fill in 'password-user' with '123456'
    And I fill in 'confirm_password' with '123456'
    And I fill in 'email' with 'gesiel@unb.br'
    And I fill in 'type' with 'department_assistant'
    When I press 'Enviar' button
    Then the initial page should load with notice message 'Insira um Cpf válido'

  Scenario: Request registration of a user with invalid cpf
    Given I am on the log in page
    When click on button 'Solicitar Cadastro'
    And I fill in 'name' with 'gesiel freitas'
    And I fill in 'cpf' with '02919147307'
    And I fill in 'registration' with '2244537'
    And I fill in 'password-user' with '123456'
    And I fill in 'confirm_password' with '123456'
    And I fill in 'email' with ''
    And I fill in 'type' with 'administrative_assistant'
    When I press 'Enviar' button
    Then the initial page should load with notice message 'E-mail não pode ser vazio'
