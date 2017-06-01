Feature: Manager Category
	To use application resources
	As a administrative assistant user
	I would like to create a new category

	Scenario: create a new category
		Given I am logged in as assistant administrative
		And click on link 'Salas'
		And click on link 'Categorias'
		And click on link 'Criar nova categoria'
		And I fill in 'name' with 'Auditório'
		When I press 'Salvar' button
		Then notice message 'Categoria criada'

	Scenario: edit a category
		Given I am logged in as assistant administrative
		And click on link 'Salas'
		And click on link 'Categorias'
		And I press 'Edit' button
		And I fill in 'name' with 'Laboratório de Eletrônica'
		When I press 'Salvar' button
		Then notice message 'Categoria atualizada com sucesso'

	Scenario: delete a category
		Given I am logged in as assistant administrative
		And click on link 'Salas'
		And click on link 'Categorias'
		And I press 'Trash' button
		When I press 'Confirm' button
		Then notice message 'Categoria excluída com sucesso'