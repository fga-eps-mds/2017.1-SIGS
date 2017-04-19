Given (/^I am at home page$/) do
  visit 'http://192.168.2.15:3000'
end

And  (/^I fill in "E-mail" with "wallacy@unb.br"$/) do
  fill_in 'session_email', with: 'wallacy@unb.br'
end

And  (/^I fill in "Senha" with "123456"$/) do
  fill_in 'session_password', with: '123456'
end

When  (/^I press "Entrar" button$/) do
  click_button ("Entrar")
end

Then (/^the page show of user should load with notice message "Login realizado com sucesso"$/) do
  expect(page).to have_content("Login realizado com sucesso")
end
