And (/^click on link 'Relatórios'$/) do
  click_link('Relatórios')
end

And (/^click on link 'Salas' in 'Relatório'$/) do
  find("a[href='/reports/by_room']").click
end

And (/^select in 'Departamento' option 'Engenharia'$/) do
	select('Engenharia', from: 'reports_by_room_departments')
end

And (/^select in 'Código da sala' option 'SS'$/) do
	select('SS', from: 'reports_by_room_room_code')
end

When (/^I press 'Gerar' button$/) do
  click_button('Gerar')
end

Then (/^generate a PDF$/) do
 	page.has_xpath?('//*[@id="plugin"]')
end

And (/^check 'Todas as salas'$/) do
	check('reports_by_room_all_rooms')
end
