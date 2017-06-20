Given(/^click on link 'Solicitações'$/) do
    first('.myList').click_link('Solicitações')
end


Then(/^request index page should be loaded$/) do
    page.has_xpath?('//index')
end
