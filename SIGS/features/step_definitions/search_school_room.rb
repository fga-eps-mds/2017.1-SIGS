And (/^click on link 'Meu Departamento'$/) do
	click_link ('Meu Departamento')
end

And (/^I fill in 'search' with 'Cal'$/) do
  find(:css, "input[id$='input-search-field']").set("Cal")
end

And (/^I fill in 'search' with 'Art'$/) do
  find(:css, "input[id$='input-search-field']").set("Art")
end

When (/^I press searchButton button$/) do
	page.find('#searchButton').click
end

Then (/^notice message 'Nenhuma turma encontrada'$/) do
  expect(page).to have_content('Nenhuma turma encontrada')
end

And (/^print the result search$/) do
  expect(page).to have_content('Cálculo 3')
  expect(page).to have_content('Cálculo 1')
end
