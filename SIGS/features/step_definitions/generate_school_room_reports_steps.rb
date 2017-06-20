And (/^click on link 'Turmas' in 'Relatório'$/) do
  first('.dropdown-menu').click_link('Turmas')
end

And (/^I fill in 'relatorio' with 'Todas'$/) do
	choose('to_all')
end

And (/^I fill in 'relatorio' with 'Alocadas'$/) do
	choose('to_allocations')
end

And (/^I fill in 'relatorio' with 'Não Alocadas'$/) do
	choose('to_not_allocations')
end

When (/^I press 'Gerar Relatório Todas as turmas' link$/) do
  click_link('Gerar Relatório Todas as turmas')
end

When (/^I press 'Gerar Relatório de Turmas Alocadas' link$/) do
  click_link('Gerar Relatório de Turmas Alocadas')
end

When (/^I press 'Gerar Relatório de turmas não Alocadas' link$/) do
  click_link('Gerar Relatório de turmas não Alocadas')
end
