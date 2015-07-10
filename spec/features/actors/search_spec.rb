require 'spec_helper.rb'

feature 'Looking up actors', js: true do
	scenario 'finding actors' do
		visit '/'
		click_on 'Actors'
		fill_in 'keywords', with: 'uma'
		click_on 'Search'

		expect(page).to have_content('Uma Thurman')
		expect(page).to_not have_content('John Travolta')
	end
end