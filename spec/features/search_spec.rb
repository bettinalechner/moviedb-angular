require 'spec_helper.rb'

feature 'Looking up movies', js: true do
	scenario 'finding movies' do
		visit '/'
		fill_in 'keywords', with: 'pulp'
		click_on 'Search'

		expect(page).to have_content('Pulp Fiction')
	end
end