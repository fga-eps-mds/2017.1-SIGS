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
  find(:css, "input[id$='school_room_name']").set("D")
end

And (/^I fill in 'capacity' with '50'$/) do
	fill_in('school_room[capacity]', :with=> '50')
end

And (/^I fill in 'capacity' with null$/) do
	fill_in('school_room[capacity]', :with=> '')
end

And (/^I fill in 'capacity' with '1'$/) do
	fill_in('school_room[capacity]', :with=> '1')
end

And (/^I fill in 'capacity' with '800'$/) do
	fill_in('school_room[capacity]', :with=> '800')
end

And (/^I fill in 'name' with 'A'$/) do
	fill_in('school_room[name]', :with=> 'A')
end

And (/^I check 'Retroprojetor'$/) do
	find(:css, "#school_room_category_ids_1").set(true)
end

And (/^I check 'Engenharia Eletronica'$/) do
   find(:css, "#school_room_course_ids_2").set(true)
end

Then (/^notice message 'Turma criada'$/) do
	expect(page).to have_content('Turma criada')
end

Then (/^notice message 'Turma com nome já cadastrado'$/) do
	expect(page).to have_content('Turma com nome já cadastrado')
end

Then (/^notice message 'Turma não pode ser vazia'$/) do
	expect(page).to have_content('Turma não pode ser vazia')
end

Then (/^notice message 'Capacidade não pode ser vazia'$/) do
	expect(page).to have_content('Capacidade não pode ser vazia')
end

Then (/^notice message 'A capacidade mínima é 5 vagas'$/) do
	expect(page).to have_content('A capacidade mínima é 5 vagas')
end

Then (/^notice message 'A capacidade máxima é 500 vagas'$/) do
	expect(page).to have_content('A capacidade máxima é 500 vagas')
end