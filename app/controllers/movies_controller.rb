class MoviesController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		@movies = if params[:keywords]
								Movie.where('title ilike ?', "%#{params[:keywords]}%")
							else
								[]
							end
	end

	def show
		@movie = Movie.find(params[:id])
	end

	def create
		@movie = Movie.new(movie_params)
		@movie.save
		render 'show', status: 201
	end

	def update
		movie = Movie.find(params[:id])
		movie.update_attributes(movie_params)
		head :no_content
	end

	def destroy
		movie = Movie.find(params[:id])
		movie.destroy
		head :no_content
	end

	private

	def movie_params
		params.require(:movie).permit(:title, :year, :rating)
	end
end
