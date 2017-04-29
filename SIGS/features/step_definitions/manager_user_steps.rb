Given (/^I am logged in as asssistant administrative$/) do
	visit 'http://192.168.2.15:3000'
	fill_in('session[email]', :with=> 'wallacy@unb.br')
	fill_in('session[password]', :with=> '123456')
	click_button('Entrar')
	expect(page).to have_content('Login realizado com sucesso')
end

When (/^click on link 'Minha Conta'$/) do
  click_link('Minha Conta')
  expect(page).to have_content('E-mail')
end

And (/^I fill in 'name' with 'Wallcy Francisco'$/) do
  fill_in('user[name]', :with=> 'Wallcy Francisco')
end

And (/^I fill in 'password-user' with '654321'$/) do
	fill_in('user[password]', :with=> '654321')
end

And (/^I fill in 'confirm_password' with '654321'$/) do
	fill_in('confirm_password', :with=> '654321')
end

And (/^I fill in 'password-user' with '654'$/) do
	fill_in('user[password]', :with=> '654')
end

And (/^I fill in 'confirm_password' with '654'$/) do
	fill_in('confirm_password', :with=> '654')
end

When (/^I press 'Salvar' button$/) do
	click_button('Salvar')
end

Then (/^the 'Minha Conta' page should load with notice message 'Dados atualizados com sucesso'$/) do
	expect(page).to have_content('Dados atualizados com sucesso')
end

Then (/^the 'Minha Conta' page should load with notice message 'Dados não foram atualizados'$/) do
	expect(page).to have_content('translation missing: en.error_profile_update')
end

When (/^I press 'Excluir Conta' button$/) do
	click_link('Excluir Conta')
end

Then (/^the initial page should load with notice message 'Conta Excluída'$/) do
	expect(page).to have_content('Conta Excluída')
end

When (/^I delete another asssistant administrative$/) do
	@user = User.find_by(email: 'carlos@unb.br')
  @user.destroy
end

Then (/^the initial page should load with notice message 'Não é possível excluir o único Assistente Administrativo'$/) do
  expect(page).to have_content('Não é possível excluir o único Assistente Administrativo')
end

And (/^click on link 'Usuários Registrados'$/) do
  click_link('Usuários Registrados')
end

When (/^I press 'Delete' button$/) do
  first(:link, 'Icon trash').click
end

Then(/^the 'Usuarios Registrados' page should load with notice message 'Usuário excluído com sucesso'$/) do
  expect(page).to have_content('Usuário excluído com sucesso')
end

When (/^I delete anothers registration users$/) do
  @users = User.find_by('email != ? and active = true', 'wallacy@unb.br')
  @users.each do |user|
    user.destroy
  end
end

Then(/^the 'Usuarios Registrados' page should load with notice message 'Não há nenhum usuário registrado no momento.'$/) do
  expect(page).to have_content('Não há nenhum usuário registrado no momento.')
end
