Feature: Keep session
  To use application resources
  As a coordinator
  I would like to start my session

  Scenario: Create session with valid user
    Given I am at home page
    And I fill in "E-mail" with "wallacy@unb.br"
    And I fill in "Senha" with "123456"
    When I press "Entrar" button
    Then the page show of user should load with notice message "Login realizado com sucesso"
