When (/^click on link 'Período'$/) do
  click_link('Período')
end

Then (/^the 'Período' page should load with periods information$/) do
  expect(page).to have_content('Alocação')
  expect(page).to have_content('10/01/2018 00:00')
  expect(page).to have_content('01/02/2018 18:00')
end

And (/^I fill in 'initial_date' with '2018-01-15T06:00:00'$/) do
  fill_in('period[initial_date]', :with=> '2018-01-15T06:00:00')
end

And (/^I fill in 'initial_date' with '2018-10-15T00:00:00'$/) do
  fill_in('period[initial_date]', :with=> '2018-10-15T00:00:00')
end

And (/^I fill in 'final_date' with '2018-02-10T18:00:00'$/) do
  fill_in('period[final_date]', :with=> '2018-02-10T18:00:00')
end

And (/^I fill in 'final_date' with '2018-03-10T18:00:00'$/) do
  fill_in('period[final_date]', :with=> '2018-03-10T18:00:00')
end

Then (/^the 'Período' page should load with 'Dados do período atualizados com sucesso'$/) do
  expect(page).to have_content('Dados do período atualizados com sucesso')
end

Then (/^the 'Editando Período' page should load with 'Dados do período não foram atualizados'$/) do
  expect(page).to have_content('Dados do período não foram atualizados')
end

And (/^the 'Editando Período' page should load with 'A Data Final deve ser depois da Data de Início'$/) do
  expect(page).to have_content('A Data Final deve ser depois da Data de Início')
end
