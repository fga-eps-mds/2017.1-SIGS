Feature: Create school room
	To use application resources
	As a coordinator user
	I would like to create a new School room

	# Scenario: create school room with valid attributes
		# Given I am logged in as coordinator
		# And click on link 'Nova Turma'
		# And I select '1' in 'discipline_id'
		# And I fill in 'name' with 'D'
		# When I press 'Salvar' button
		# Then notice message 'Turma criada'

	# Scenario: create school room with valid attributes adding category and course
		# Given I am logged in as coordinator
		# And click on link 'Nova Turma'
		# And I select '1' in 'discipline_id'
		# And I check 'Engenharia Eletronica'
		# And I check 'Retroprojetor'
		# And I fill in 'name' with 'D'
		# When I press 'Salvar' button
		# Then notice message 'Turma criada'

	# Scenario: create school room with null name attributes
		# Given I am logged in as coordinator
		# And click on link 'Nova Turma'
		# And I select '1' in 'discipline_id'
		# When I press 'Salvar' button
		# Then notice message 'Indique o nome da turma'


	# Scenario: create school room with existent name attributes
		# Given I am logged in as coordinator
		# And click on link 'Nova Turma'
		# And I select '1' in 'discipline_id'
		# And I fill in 'name' with 'A'
		# When I press 'Salvar' button
		# Then notice message 'Já existe uma turma com esse nome'
