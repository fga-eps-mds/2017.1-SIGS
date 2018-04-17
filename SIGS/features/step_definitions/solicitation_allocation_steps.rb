And (/^change date of allocation period$/) do
    Period.find_by(period_type:'Alocação').update(initial_date: Date.current - 5.days, final_date: Date.current - 1.days)
end

When (/^click in solicitation link$/) do
  find("a[href='/solicitations/allocation_period/3']").click
end

Then (/^expected 'Período de Alocação'$/) do
	expect(page).to have_content('Período de Alocação')
end

Then (/^expected 'Período de Ajuste'$/) do
	expect(page).to have_content('Período de Ajuste')
end

And (/^select 'PRC' in department$/) do
  page.select 'PRC', :from => 'solicitation[departments]'
end

And (/^I fill justification$/) do
  fill_in('solicitation[justify]', :with=> 'Request allocation test')
end

When (/^click on button 'Enviar'$/) do
  click_button('Enviar')
end

Then(/^I expect 'Selecione o horário que deseja'$/) do
  expect(page).to have_content('Selecione o horário que deseja')
end

Given(/^I am in the allocation period$/) do
  Period.find_by(period_type:'Alocação').update(initial_date: Date.current - 5.days, final_date: Date.current + 1.days)
end
