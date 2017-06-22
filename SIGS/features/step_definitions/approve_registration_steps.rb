And (/^click on link 'Usuários'$/) do
	first(:link, 'Usuários').click
end

And (/^click on link 'Cadastros Pendentes'$/) do
	first(:link,'Cadastros Pendentes').click
end

When (/^I press 'Approve' button$/) do
	first(:link, 'Approve').click
end

When (/^I press 'Recuse' button$/) do
	first(:link, 'Recuse').click
end

Then (/^the request should be deleted and notice message 'Usuário aprovado com sucesso'$/) do
	expect(page).to have_content('Usuário aprovado com sucesso')
end

Then (/^the request should be deleted and notice message 'Usuário recusado com sucesso'$/) do
	expect(page).to have_content('Usuário recusado com sucesso')
end

Then (/^notice message 'Não há nenhuma solicitação pendente no momento.'$/) do
	expect(page).to have_content('Não há nenhuma solicitação pendente no momento.')
end
