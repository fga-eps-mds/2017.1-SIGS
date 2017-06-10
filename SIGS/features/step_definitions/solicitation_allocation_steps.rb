And (/^change date of allocation period$/) do
    Period.find_by(period_type:'Alocação').update(initial_date: Date.current - 5.days, final_date: Date.current + 5.days)
end

When (/^click in solicitation link$/) do
	first('.icon_alloc').click
end

Then (/^expected 'Cálculo 1'$/) do
	expect(page).to have_content('Cálculo 1')
end