And (/^clicar no botão de "Solicitar Cadastro"$/) do
	click_link ("Solicitar Cadastro")
end

And (/^I fill in "name" with "gesiel freitas"$/) do
	fill_in('user[name]', :with=> 'gesiel freitas')
end
And (/^I fill in "cpf" with "02919147307"$/) do
	fill_in('user[cpf]', :with=> '02919147307')
end
And (/^I fill in "registration" with "1234567"$/) do
	fill_in('user[registration]', :with=> '1234567')
end

And (/^I fill in "password-user" with "123456"$/) do
	fill_in('user[password]', :with=> '123456')
end

And (/^I fill in "confirm_password" with "123456"$/) do
	fill_in('user[password_confirmation]', :with=> '123456')
end

And (/^I fill in "email" with "gesiel@unb.br"$/) do
	fill_in('user[email]', :with=> 'gesiel@unb.br')
end
And (/^I fill in "categoria" with "administrative_assistant"$/) do
	choose("adm_as")
end

When (/^I press "Enviar" button$/) do
	click_button("Enviar")
end

Then (/^the initial page should load with notice message "Solicitação de cadastro efetuado com sucesso!"$/) do
	expect(page).to have_content("Solicitação de cadastro efetuado com sucesso!")
end