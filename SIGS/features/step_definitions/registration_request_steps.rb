When (/^click on button 'Solicitar Cadastro'$/) do
	click_link ('Solicitar Cadastro')
end

And (/^I fill in 'name' with 'gesiel freitas'$/) do
	fill_in('user[name]', :with=> 'gesiel freitas')
end

And (/^I fill in 'name' with 'Ana'$/) do
	fill_in('user[name]', :with=> 'Ana')
end

And (/^I fill in 'cpf' with '02919147307'$/) do
	fill_in('user[cpf]', :with=> '02919147307')
end

And (/^I fill in 'cpf' with '1234'$/) do
	fill_in('user[cpf]', :with=> '1234')
end

And (/^I fill in 'registration' with '2244537'$/) do
	fill_in('user[registration]', :with=> '2244537')
end

And (/^I fill in 'password-user' with '123456'$/) do
	fill_in('user[password]', :with=> '123456')
end

And (/^I fill in 'confirm_password' with '123456'$/) do
	fill_in('user[password_confirmation]', :with=> '123456')
end

And (/^I fill in 'email' with 'gesiel@unb.br'$/) do
	fill_in('user[email]', :with=> 'gesiel@unb.br')
end

And (/^I fill in 'email' with ''$/) do
	fill_in('user[email]', :with=> '')
end

And (/^I fill in 'type' with 'administrative_assistant'$/) do
	choose('adm_as')
end

And (/^I fill in 'type' with 'coordinator'$/) do
	choose('coord')
end

And (/^I fill in 'type' with 'department_assistant'$/) do
	choose('dep_as')
end

When (/^I press 'Enviar' button$/) do
	click_button('Enviar')
end

Then (/^the initial page should load with notice message 'Solicitação de cadastro efetuado com sucesso!'$/) do
	expect(page).to have_content('Solicitação de cadastro efetuado com sucesso!')
end

Then (/^the initial page should load with notice message 'O Nome deve ter no mínimo 7 caracteres'$/) do
	expect(page).to have_content('O Nome deve ter no mínimo 7 caracteres')
end

Then (/^the initial page should load with notice message 'Insira um Cpf válido'$/) do
	expect(page).to have_content('Insira um Cpf válido')
end

Then (/^the initial page should load with notice message 'E-mail não pode ser vazio'$/) do
	expect(page).to have_content('E-mail não pode ser vazio')
end
