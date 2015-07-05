require 'spec_helper.rb'

feature 'Viewing a movie', js: true do
	before do
		Movie.create!({ title: 'Pulp Fiction', year: '1994', rating: 9 })
		Movie.create!({ title: 'Kill Bill: Vol. 1', year: '2003', rating: 8 })
	end

	scenario 'view one movie' do
		visit '/'
		fill_in 'keywords', with: 'pulp'
		click_on 'Search'

		click_on 'Pulp Fiction'

		expect(page).to have_content('Pulp Fiction')
		expect(page).to have_content('1994')

		click_on 'Back'

		expect(page).to have_content('Pulp Fiction')
		expect(page).to_not have_content('1994')
	end
end