And (/^click on link 'Categorias'$/) do
  click_link('Categorias')
end

And (/^click on link 'Criar nova categoria'$/) do
  click_button('Criar nova categoria')
end

And (/^I fill in 'name' with 'Auditório'$/) do
  fill_in('category[name]', :with=> 'Auditório')
end

And (/^I fill in 'name' with 'Laboratório de Eletrônica'$/) do
	fill_in('category[name]', :with=> 'Laboratório de Eletrônica')
end

And (/^I press 'Edit' button$/) do
  first(:link, 'Icon edit').click
end

And (/^I press 'Trash' button$/) do
  first(:link, 'Icon trash').click
end

When (/^I press 'Confirm' button$/) do
  	first('.btn', visible: false).click
end

Then (/^notice message 'Categoria criada'$/) do
	expect(page).to have_selector '.alert', text: 'Categoria criada'
end

Then (/^notice message 'Categoria atualizada com sucesso'$/) do
	expect(page).to have_selector '.alert', text: 'Categoria atualizada com sucesso'
end

Then (/^notice message 'Categoria excluída com sucesso'$/) do
	expect(page).to have_selector '.alert', text: 'Categoria excluída com sucesso'
end