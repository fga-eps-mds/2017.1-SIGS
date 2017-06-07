
And (/^click on edit first$/) do
    first(:link, 'Icon edit').click
end

When (/^I press 'Alterar' button$/) do
    click_button('Alterar')
end

Then (/^notice message 'A turma foi alterada com sucesso'$/) do
	expect(page).to have_content('A turma foi alterada com sucesso')
end

Then (/^notice message 'Turma deve haver pelo menos um curso'$/) do
	expect(page).to have_content('Turma deve haver pelo menos um curso')
end

And (/^I uncheck 'Engenharia Eletronica'$/) do
   find(:css, "#school_room_course_ids_2").set(false)
end

And (/^I uncheck 'Engenharia Automotiva'$/) do
   find(:css, "#school_room_course_ids_3").set(false)
end

And (/^I uncheck 'Artes Visuais'$/) do
   find(:css, "#school_room_course_ids_4").set(false)
end
