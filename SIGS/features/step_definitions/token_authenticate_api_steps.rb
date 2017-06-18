And (/^click on link 'API'$/) do
  click_link('API')
end

And (/^click on link 'Gerenciar Usuários'$/) do
  click_link('Gerenciar Usuários')
end

And (/^delete all API users$/) do
  api_users = ApiUser.all
  api_users.each do |api_user|
    api_user.destroy
  end
end

And (/^click on link 'Criar Usuário de API'$/) do
  click_link('Criar Usuário de API')
end

And (/^click on link 'Icon edit'$/) do
  click_link('Icon edit', match: :first)
end

And (/^click on link 'Icon trash'$/) do
  click_link('Icon trash', match: :first)
end

And (/^I fill in 'name' with 'Otavio Socrates'$/) do
  fill_in('api_user[name]', with: 'Otavio Socrates')
end

And (/^I fill in 'name' with 'Paula'$/) do
  fill_in('api_user[name]', with: 'Paula')
end

And (/^I fill in 'name' with 'Ana Paula Chaves'$/) do
  fill_in('api_user[name]', with: 'Ana Paula Chaves')
end

And (/^I fill in 'name' with 'Hendrick Mathews'$/) do
  fill_in('api_user[name]', with: 'Hendrick Mathews')
end

And (/^I fill in 'name' with 'Thay'$/) do
  fill_in('api_user[name]', with: 'Thay')
end

And (/^I fill in 'email' with 'otavio.socrates@hotmail.com'$/) do
  fill_in('api_user[email]', with: 'otavio.socrates@hotmail.com')
end

And (/^I fill in 'email' with 'aninha'$/) do
  fill_in('api_user[email]', with: 'aninha')
end

And (/^I fill in 'email' with 'anapaula.chaves@gmail.com'$/) do
  fill_in('api_user[email]', with: 'anapaula.chaves@gmail.com')
end

And (/^I fill in 'email' with 'hendrick.mathews@gmail.com'$/) do
  fill_in('api_user[email]', with: 'hendrick.mathews@gmail.com')
end

And (/^I fill in 'email' with 'thay'$/) do
  fill_in('api_user[email]', with: 'thay')
end

Then (/^the page 'Usuário de API' must show two API users$/) do
  expect(page).to have_content('Usuários de API')
  expect(page).to have_content('Ana Paula Chaves')
  expect(page).to have_content('anapaula.chaves@gmail.com')
  expect(page).to have_content('Gustavo Freire Oliveira')
  expect(page).to have_content('freire.oliveira@hotmail.com')
end

Then (/^the page 'Usuário de API' must show no one API users$/) do
  expect(page).to have_content('Usuários de API')
  expect(page).to have_content('Não há usuários de API registrados em seu nome.')
end

Then (/^the page 'Usuário de API' notice message 'Usuário de API salvo'$/) do
  expect(page).to have_content('Usuário de API salvo')
end

Then(/^the page 'Criar Usuário de API' notice message 'Usuário de API não foi salvo'$/) do
  expect(page).to have_content('Usuário de API não foi salvo')
end

Then (/^the page 'Editar Usuário de API' notice message 'Usuário de API atualizado com sucesso'$/) do
  expect(page).to have_content('Usuário de API atualizado com sucesso')
end

Then(/^the page 'Editar Usuário de API' notice message 'Usuário de API não pode ser atualizado'$/) do
  expect(page).to have_content('Usuário de API não pode ser atualizado')
end

Then (/^the page 'Usuário de API' notice message 'Usuário de API excluido com sucesso'$/) do
  expect(page).to have_content('Usuário de API excluido com sucesso')
end

And (/^the page 'Usuário de API' must show the details of API user Otavio Socrates$/) do
  expect(page).to have_content('Usuário: Otavio Socrates')
  expect(page).to have_content('E-mail: otavio.socrates@hotmail.com')
  expect(page).to have_content('Chave:')
  expect(page).to have_content('Token de Acesso:')
end

And (/^the page 'Usuário de API' must show the details of API user Hendrick Mathews$/) do
  expect(page).to have_content('Usuário: Hendrick Mathews')
  expect(page).to have_content('E-mail: hendrick.mathews@gmail.com')
  expect(page).to have_content('Chave:')
  expect(page).to have_content('Token de Acesso:')
end

And (/^the page 'Criar Usuário de API' must show the errors$/) do
  expect(page).to have_content('O Nome deve ter no mínimo 7 caracteres')
  expect(page).to have_content('Insira um E-mail válido')
  expect(page).to have_content('O E-mail deve ter no mínimo 7 caracteres')
end

And (/^the page 'Criar Usuário de API' must show the error of repeated email$/) do
  expect(page).to have_content('E-mail já cadastrado no sistema')
end
