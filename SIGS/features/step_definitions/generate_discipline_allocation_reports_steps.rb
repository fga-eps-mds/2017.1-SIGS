And (/^click on link 'Icon pdf'$/) do
  click_link('Icon pdf', match: :first)
end

And (/^click on button 'searchButton'$/) do
  click_button('searchButton')
end

And (/^click on link 'Disciplinas' in 'Relatório'$/) do
    find("a[href='/reports_disciplines/by_discipline']").click
end

And (/^fill 'name' with 'Artes'$/) do
    fill_in('name', :with => 'Artes')
end

And (/^fill 'name' with 'X'$/) do
    fill_in('name', :with => 'X')
end

And (/^fill 'name' with ''$/) do
    fill_in('name', :with => '')
end

Then (/^the 'Relatório por Disciplina' page show some disciplines$/) do
    expect(page).to have_content('Cálculo 3')
    expect(page).to have_content('Cálculo 2')
    expect(page).to have_content('Cálculo 1')
    expect(page).to have_content('Artes Visuais')
end

Then (/^the 'Relatório por Disciplina' page show 'Artes Visuais'$/) do
    expect(page).to have_content('Artes Visuais')
end

Then (/^the 'Relatório por Disciplina' page show 'Não há disciplinas registradas.'$/) do
    expect(page).to have_content('Não há disciplinas registradas.')
end
