And (/^click on link 'Icon pdf' in 'Pavilhão Anísio Teixeira'$/) do
  find("a[href='/reports/generate_by_building/2']").click
end

And (/^click on link 'Prédios' in 'Relatório'$/) do
    find("a[href='/reports/by_building']").click
end

And (/^fill 'search' with 'Anísio'$/) do
    fill_in('search', with: 'Anísio')
end

And (/^fill 'search' with 'teste'$/) do
    fill_in('search', with: 'teste')
end

And (/^fill 'search' with ''$/) do
    fill_in('search', with: '')
end

Then (/^the 'Relatório por Prédios' page show some buildings$/) do
    expect(page).to have_content('Pavilhão João Calmon')
    expect(page).to have_content('Pavilhão Anísio Teixeira')
    expect(page).to have_content('Bloco de Salas da Ala Sul')
    expect(page).to have_content('Bloco de Salas da Ala Norte')
end

Then (/^the 'Relatório por Prédios' page show 'Pavilhão Anísio Teixeira'$/) do
    expect(page).to have_content('Pavilhão Anísio Teixeira')
end

Then (/^the 'Relatório por Prédios' page show 'Não há prédios registrados.'$/) do
    expect(page).to have_content('Não há prédios registrados.')
end
