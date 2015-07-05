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

	describe 'show' do
		before do
			xhr :get, :show, format: :json, id: movie_id
		end

		subject(:results) { JSON.parse(response.body) }

		context "when the movie exists" do
			let(:movie) {
				Movie.create!({ title: 'Serenity', year: '2005', rating: 8 })
			}

			let(:movie_id) { movie.id }

			it { expect(response.status).to eq(200) }
			it { expect(results['id']).to eq(movie.id) }
			it { expect(results['title']).to eq(movie.title) }
			it { expect(results['year']).to eq(movie.year) }
			it { expect(results['rating']).to eq(movie.rating) }
		end

		context "when the movie doesn't exist" do
			let(:movie_id) { -9999 }
			it { expect(response.status).to eq(404) }
		end
	end

	describe 'create' do
		before do
			xhr :post, :create, format: :json, movie: {
				title: 'Serenity',
				year: '2005',
				rating: 8
			}
		end

		it { expect(response.status).to eq(201) }
		it { expect(Movie.last.title).to eq('Serenity') }
		it { expect(Movie.last.year).to eq('2005') }
		it { expect(Movie.last.rating).to eq(8) }
	end

	describe 'update' do
		let(:movie) {
			Movie.create!({
				title: 'Serenity',
				year: '2005',
				rating: 8
			})
		}

		before do
			xhr :put, :update, format: :json, id: movie.id, movie: {
				rating: 9
			}
			movie.reload
		end

		it { expect(response.status).to eq(204) }
		it { expect(Movie.last.title).to eq('Serenity') }
		it { expect(Movie.last.year).to eq('2005') }
		it { expect(Movie.last.rating).to eq(9) }		
	end

	describe 'destroy' do
		let(:movie_id) {
			Movie.create!({
				title: 'Serenity',
				year: '2005',
				rating: 8
			}).id
		}

		before do
			xhr :delete, :destroy, format: :json, id: movie_id
		end

		it { expect(response.status).to eq(204) }
		it { expect(Movie.find_by_id(movie_id)).to be_nil }
	end
end
