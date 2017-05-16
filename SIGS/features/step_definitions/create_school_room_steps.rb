Given (/^I am logged in as coordinator$/) do
	visit 'http://192.168.2.15:3000'
	fill_in('session[email]', :with=> 'pedro@unb.br')
	fill_in('session[password]', :with=> '123456')
  	click_button('Entrar')
end

And (/^click on link 'Turmas'$/) do
	click_link ('Turmas')
end

And (/^I select '' in 'discipline_id'$/) do
	find_field('school_room_discipline_id').find("option[value='']").text
end

And (/^I fill in 'name' with 'D'$/) do
	fill_in('school_room[name]', :with=> 'D')
end

Then (/^notice message 'create'$/) do
	expect(page).to have_content('create')
end
