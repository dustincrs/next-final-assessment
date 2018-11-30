class SessionsController < ApplicationController

	def create
		user = User.find_by(email: session_params[:email])

		if !user.nil?
			if user.authenticate(session_params[:password])
				helpers.sign_in(user)
				flash[:notice] = "Successfully signed in!"
			else
				flash[:notice] = "Incorrect password!"
			end
		else
			flash[:notice] = "The user was not found in the records."
		end

		redirect_to root_path
	end

	def destroy
		helpers.sign_out
		flash[:notice] = "Signed out!"
		redirect_to root_path
	end

	private
	def session_params
		params.permit(:email, :password)
	end
end
