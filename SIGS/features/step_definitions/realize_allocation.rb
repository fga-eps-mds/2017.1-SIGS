And (/^click on button 'Alocar' to 'Cálculo 1'$/) do
  first(:link, 'Icon alloc').click
end

And (/^select Sala 'S10' of select-room droplist'$/) do
  select('S10', from: 'select-room')
end

And (/^click on checkbox 'check_Quinta_18'$/) do
  page.execute_script("ajaxReloadTable()")
  check 'check_Quinta_18'
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
