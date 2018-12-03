class ApplicationController < ActionController::Base

	private
	def require_login
		if(!helpers.signed_in?)
			redirect_to root_path
		end
	end
end
