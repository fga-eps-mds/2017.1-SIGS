Feature: Login
	To use application resources
	As a system user
	I would like to log in with my account

	Scenario: Log in a valid user
		Given I am on the log in page
		When clicar no botão de "Solicitar Cadastro"
		And I fill in "name" with "gesiel freitas"
		And I fill in "cpf" with "02919147307"
		And I fill in "registration" with "1234567"
		And I fill in "password-user" with "123456"
		And I fill in "confirm_password" with "123456"
		And I fill in "email" with "gesiel@unb.br"
		And I fill in "categoria" with "administrative_assistant"
		When I press "Enviar" button
		Then the initial page should load with notice message "Solicitação de cadastro efetuado com sucesso!"

	