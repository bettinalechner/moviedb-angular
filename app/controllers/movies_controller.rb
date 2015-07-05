class MoviesController < ApplicationController
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
end
