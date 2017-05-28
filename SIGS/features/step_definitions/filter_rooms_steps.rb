And (/^I fill in 'name' with 'S10'$/) do
  fill_in(:name, with: 'S10')
end

And (/^I fill in 'name' with 'S100'$/) do
  fill_in(:name, with: 'S100')
end

And (/^I fill in 'code' with '987653'$/) do
  fill_in(:code, with: '987653')
end

And (/^I fill in 'code' with '999999'$/) do
  fill_in(:code, with: '999999')
end

And (/^I fill in 'capacity' with '50'$/) do
  fill_in(:capacity, with: '50')
end

And (/^I select 'Pavilhão João Calmon'/) do
	select 'Pavilhão João Calmon', from: 'building_id';	
end

Then (/^the 'Salas' page should load with message 'S10'$/) do

  expect(page).to have_content('S10')
end

Then (/^the 'Salas' page should load with message '987653'$/) do
  expect(page).to have_content('987653')
end

Then (/^the 'Salas' page should load with message '124325'$/) do
  expect(page).to have_content('124325')
end

Then (/^the 'Salas' page should load with message 'Pavilhão João Calmon'$/) do
	expect(page).to have_content('Pavilhão João Calmon')
end

And (/^I press 'Submit' button$/) do
  click_button('Submit')
end