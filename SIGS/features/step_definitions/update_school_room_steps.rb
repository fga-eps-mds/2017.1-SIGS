
And (/^click on link 'Meu Departamento'$/) do
	click_link ('Meu Departamento')
end

And (/^click on edit first$/) do
    first(:link, 'Icon edit').click
end

When (/^I press 'Alterar' button$/) do
    click_button('Alterar')
end

Then (/^notice message 'A turma foi alterada com sucesso'$/) do
	expect(page).to have_content('A turma foi alterada com sucesso')
end


