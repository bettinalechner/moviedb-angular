require 'spec_helper.rb'

feature 'Creating, editing, and deleting a movie', js: true do
	scenario 'CRUD a movie' do
		visit '/'
		click on 'New Movie'

		fill_in 'title', with: 'Serenity'
		fill_in 'year', with: 2005
		fill_in 'rating', with: 9

		click_on 'Save'

		expect(page).to have_content('Serenity')
		expect(page).to have_content('2005')
		expect(page).to have_content('9')

		click_on 'Edit'

		fill_in 'rating', with: 8

		click_on 'Save'

		expect(page).to have_content(8)

		visit '/'
		fill_in 'keywords', with: 'seren'
		click_on 'Search'

		click_on 'Serenity'

		click_on 'Delete'

		expect(Movie.find_by_title('Serenity')).to be_nil
	end
end