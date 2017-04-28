Feature: Approve registration
	To use application resources
	As a administrative assistantt user
	I would like to approve or recuse registration

	Scenario: approve a registration
		Given I am logged in as asssistant administrative
		And click on link 'Usuários'
		And click on link 'Cadastros Pendentes'
		When I press 'Approve' button
		Then the request should be deleted and notice message 'Usuário aprovado com sucesso'

	Scenario: recuse a registration
		Given I am logged in as asssistant administrative
		And click on link 'Usuários'
		And click on link 'Cadastros Pendentes'
		When I press 'Recuse' button
		Then the request should be deleted and notice message 'Usuário recusado com sucesso'
