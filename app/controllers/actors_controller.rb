class ActorsController < ApplicationController
  def index
  	@actors = if params[:keywords]
  							Actor.where('first_name ilike ?', "%#{params[:keywords]}%")
  						else
  							[]
  						end
  end
end
