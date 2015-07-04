require 'spec_helper'

describe MoviesController do
	render_views

	describe 'index' do
		before do
			Movie.create({ title: 'Pulp Fiction', year: '1994', rating: 9 })
			Movie.create({ title: 'Kill Bill: Vol. 1', year: '2003', rating: 8 })
			Movie.create({ title: 'Kill Bill: Vol. 2', year: '2004', rating: 8 })

			xhr :get, :index, format: :json, keywords: keywords
		end

		subject(:results) { JSON.parse(response.body) }

		def extract_title
			->(object) { object['title'] }
		end

		context 'when the search finds results' do
			let(:keywords) { 'pulp' }

			it 'should 200' do
				expect(response.status).to eq(200)
			end

			it 'should return two results' do
				expect(results.size).to eq(1)
			end

			it 'should include Pulp Fiction' do
				expect(results.map(&extract_title)).to include('Pulp Fiction')
			end
		end

		context "when the search doesn't find results" do
			let(:keywords) { 'foo' }

			it 'should return no results' do
				expect(results.size).to eq(0)
			end
		end
	end
end
