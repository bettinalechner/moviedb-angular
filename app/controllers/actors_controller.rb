class ActorsController < ApplicationController
  def index
  	@actors = if params[:keywords]
  							Actor.where('first_name ilike ?', "%#{params[:keywords]}%")
  						else
  							[]
  						end
  end

  def show
  	@actor = Actor.find(params[:id])
  end
end
