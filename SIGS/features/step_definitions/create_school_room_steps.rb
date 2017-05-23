Given (/^I am logged in as coordinator$/) do
	visit 'http://192.168.2.15:3000'
	fill_in('session[email]', :with=> 'caio@unb.br')
	fill_in('session[password]', :with=> '123456')
  	click_button('Entrar')
end

And (/^click on link 'Nova Turma'$/) do
	click_link ('Nova Turma')
end

And (/^I select '1' in 'discipline_id'$/) do
	find_field('school_room_discipline_id').find("option[value='1']").text
end

And (/^I fill in 'name' with 'D'$/) do
	fill_in('school_room[name]', :with=> 'D')
end

And (/^I fill in 'type' with 'Engenharia de Software'$/) do
   find(:css, "#school_room_course_ids_1").set(true)
end

Then (/^notice message 'Turma criada'$/) do
	expect(page).to have_content('Turma criada')
end
