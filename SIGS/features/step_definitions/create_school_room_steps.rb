And (/^click on link 'Turmas'$/) do
	click_link ('Turmas')
end

And (/^I select '' in 'discipline_id'$/) do
	find_field('school_room_discipline_id').find("option[value='']").text
end

And (/^I fill in 'name' with 'D'$/) do
	fill_in('school_room[name]', :with=> 'D')
end

And (/^I fill in 'type' with 'Engenharia de Software'$/) do
   check(find("input[type='checkbox']")[:id])
end

Then (/^notice message 'create'$/) do
	expect(page).to have_content('create')
end

