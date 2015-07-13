require 'spec_helper.rb'

feature 'Viewing an actor', js: true do
	before do
		Actor.create!({ first_name: 'Uma', last_name: 'Thurman', date_of_birth: '1970-04-29'})
		Actor.create!({ first_name: 'Lucy', last_name: 'Liu', date_of_birth: '1968-12-02'})
		Actor.create!({ first_name: 'John', last_name: 'Travolta', date_of_birth: '1954-02-18'})
	end

	scenario 'view one actor' do
		visit '/'
		click_on 'Actors'

		fill_in 'keywords', with: 'uma'
		click_on 'Search'

		click_on 'Uma'

		expect(page).to have_content('Uma Thurman')
		expect(page).to have_content('Age')

		click_on 'Back'

		expect(page).to have_content('Uma Thurman')
		expect(page).to_not have_content('Age')
	end
end