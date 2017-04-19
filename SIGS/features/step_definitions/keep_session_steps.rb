Given (/^I am on the log in page$/) do
	visit 'http://192.168.2.15:3000'
end

And (/^I fill in "email" with "caio@unb.br"$/) do
	fill_in('session[email]', :with=> 'caio@unb.br')
end

And (/^I fill in "email" with "invalidbot"$/) do
	fill_in('session[email]', :with=> 'invalidbot')
end

And (/^I fill in "password" with "123456"$/) do
	fill_in('session[password]', :with=> '123456')
end

When (/^I press "Entrar" button$/) do
	click_button("Entrar")
end

Then (/^the initial page should load with notice message "Login realizado com sucesso"$/) do
	expect(page).to have_content("Email ou senha incorretos")
end

Then (/^the login page should reload with notice message "Login ou senha inválidos"$/) do
	expect(page).to have_content("Email ou senha incorretos")
end