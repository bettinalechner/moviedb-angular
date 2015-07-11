class ActorsController < ApplicationController
  skip_before_filter :verify_authenticity_token

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

  def create
    @actor = Actor.new(actor_params)
    @actor.save

    render 'show', status: 201
  end

  def update
    actor = Actor.find(params[:id])
    actor.update_attributes(actor_params)
    head :no_content
  end

  def destroy
    actor = Actor.find(params[:id])
    actor.destroy
    head :no_content
  end

  private

  def actor_params
    params.require(:actor).permit(:first_name, :last_name, :date_of_birth)
  end
end
