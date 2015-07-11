require 'spec_helper.rb'

feature 'Creating, editing, and deleting an actor', js: true do
	scenario 'CRUD an actor' do
		visit '/'
		click_on 'New Actor'

		fill_in 'firstName', with: 'Tom'
		fill_in 'lastName', with: 'Hanks'
		fill_in 'dateOfBirth', with: '1956-07-09'

		click_on 'Save'

		expect(page).to have_content('Tom Hanks')
		expect(page).to have_content('1956')

		click_on 'Edit'

		fill_in 'lastName', with: 'Hardy'
		fill_in 'dateOfBirth', with: '1977-09-15'

		click_on 'Save'

		expect(page).to have_content('Tom Hardy')
		expect(page).to have_content('1977')

		visit '/'
		click_on 'Actors'
		fill_in 'keywords', with: 'tom'
		click_on 'Serach'

		click_on 'Tom Hardy'

		click_on 'Delete'

		expect(Actor.find_by_name('Tom Hardy')).to be_nil
	end
end