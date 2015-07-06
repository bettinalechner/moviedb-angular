require 'spec_helper.rb'

feature 'Looking up movies', js: true do
	before do
		Movie.create!({ title: 'Pulp Fiction', year: '1994', rating: 9 })
		Movie.create!({ title: 'Kill Bill: Vol. 1', year: '2003', rating: 8 })
		Movie.create!({ title: 'Kill Bill: Vol. 2', year: '2004', rating: 8 })
	end

	scenario 'finding movies' do
		visit '/'
		fill_in 'keywords', with: 'kill'
		click_on 'Search'

		expect(page).to have_content('Kill Bill')
	end
end