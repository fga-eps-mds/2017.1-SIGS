Given (/^I am logged in as Caio, an coordinator$/) do
  visit 'http://192.168.2.15:3000'
  fill_in('session[email]', with: 'caio@unb.br')
  fill_in('session[password]', with: '123456')
  click_button('Entrar')
end

And (/^I choose SchoolRoom with name 'D'$/) do 
  expect(page).to have_content('D')  
end

And (/^I click on view icon$/) do 
  page.find("#icon_visualizarD").click
end

When (/^I press the "Excluir Turma" button$/) do
  click_button("Excluir Turma")
end

Then (/^notice message 'A turma foi excluída com sucesso'$/) do
  expect(page).to have_content('Suas Turmas')
end

