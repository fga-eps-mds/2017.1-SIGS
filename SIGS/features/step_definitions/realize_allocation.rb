And (/^click on link 'Alocações'$/) do
  click_link('Alocações')
end

And (/^click on link 'Graduação'$/) do
  click_link('Graduação')
end

And (/^select Turma 'A' of Turma droplist$/) do
  expect(page).to have_content('Turma')
  select('A', from: 'sala')
  @school_room_id = find('#sala').value
  # page.execute_script("$('hidden_field_id').my_function()")
end

And (/^select Turma 'D' of Turma droplist$/) do
  expect(page).to have_content('Turma')
  select('D', from: 'sala')
  @school_room_id = find('#sala').value
  # page.execute_script("$('hidden_field_id').my_function()")
end

And (/^click on button 'Segunda'$/) do
  click_button('Segunda')
  expect(page).to have_content('Alocar Segunda')
end

And (/^click on button 'Quarta'$/) do
  click_button('Quarta')
  expect(page).to have_content('Alocar Quarta')
end

And (/^click on button 'Sexta'$/) do
  click_button('Sexta')
  expect(page).to have_content('Alocar Sexta')
end

And (/^select Sala 'S10' of Sala droplist$/) do
  select('S10', from: 'allocation_room_id', match: :first)
  first('input#allocation_school_room_id', visible: false, match: :first).set("#{@school_room_id}")
end

And (/^select Sala 'S8' of Sala droplist$/) do
  select('S8', from: 'allocation_room_id', match: :first)
  first('input#allocation_school_room_id', visible: false, match: :first).set("#{@school_room_id}")
end

And (/^I fill in 'allocation-start_time' with '10:00'$/) do
  fill_in('allocation[start_time]', :with=> '10:00', match: :first)
end

And (/^I fill in 'allocation-start_time' with '12:00'$/) do
  fill_in('allocation[start_time]', :with=> '12:00', match: :first)
end

And (/^I fill in 'allocation-final_time' with '12:00'$/) do
  fill_in('allocation[final_time]', :with=> '12:00', match: :first)
end

And (/^I fill in 'allocation-final_time' with '10:00'$/) do
  fill_in('allocation[final_time]', :with=> '10:00', match: :first)
end

When (/^I press 'Salvar' button of 'Segunda'$/) do
  click_button('Salvar', match: :first)
end

When (/^I press 'Salvar' button of 'Quarta'$/) do
  page.all(:button, 'Salvar')[2].click
end

When (/^I press 'Salvar' button of 'Sexta'$/) do
  page.all(:button, 'Salvar')[4].click
end

Then(/^the 'Alocação' page should load with notice message 'Alocação feita com sucesso'$/) do
  expect(page).to have_content('Alocação feita com sucesso')
end

Then (/^the 'Alocação' page should load with notice message 'Alocação com horário não vago ou capacidade da sala cheia'$/) do
  expect(page).to have_content('Alocação com horário não vago ou capacidade da sala cheia')
end

Then(/^the 'Alocação' page should load with notice message 'Horário inválido'$/) do
  expect(page).to have_content('Horário inválido')
end

Given (/^I allocated  school room 'A' on room 'S10' at '10:00' until '12:00'$/) do
  Allocation.create(active: true, user_id: 1, school_room_id: 1, room_id: 1, day: 'Segunda', start_time: '10:00', final_time: '12:00')
end

Given (/^I allocated  school room 'A' on room 'S8' at '10:00' until '12:00'$/) do
  Allocation.create(active: true, user_id: 1, school_room_id: 1, room_id: 4, day: 'Segunda', start_time: '10:00', final_time: '12:00')
end
