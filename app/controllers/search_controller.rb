class SearchController < ApplicationController
	before_action :require_login

	def show
	end

	def search
		results = User.search_by_name(search_params[:query]).reorder(score: :desc)
		
		respond_to do |format|
			format.html	{render partial: '/search/result', collection: results}
		end
	end

	private
	def search_params
		params.permit(:query)
	end
end
