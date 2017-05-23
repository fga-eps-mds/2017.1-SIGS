Given (/^I am logged in as coordinator$/) do
	visit 'http://192.168.2.15:3000'
	fill_in('session[email]', :with=> 'caio@unb.br')
	fill_in('session[password]', :with=> '123456')
  	click_button('Entrar')
end

And (/^click on link 'Turmas'$/) do
	click_link ('Turmas')
end

And (/^I click on link 'Criar Turma'$/) do
    click_link('Criar Turma')
end

And (/^I select '' in 'discipline_id'$/) do
	expect(page).to have_content('Nova Turma')
end

And (/^I fill in 'name' with 'D'$/) do
	#fill_in 'school_room[name]', with: 'D'
  find(:css, "input[id$='school_room_name']").set("D")
end

And (/^I fill in 'type' with 'Engenharia de Software'$/) do
   find(:css, "#school_room_course_ids_2").set(true)
end

Then (/^notice message 'create'$/) do
	expect(page).to have_content('Suas Turmas')
end

