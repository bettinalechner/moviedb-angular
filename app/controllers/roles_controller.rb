class RolesController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		@role = Role.new(role_params)
		@role.save
		render 'show', status: 201
	end

	def update
		role = Role.find(params[:id])
		role.update(role_params)
		head :no_content
	end

	def destroy
		role = Role.find(params[:id])
		role.destroy
		head :no_content
	end

	private

	def role_params
		params.require(:role).permit(:name, :actor_id, :movie_id)
	end
end
