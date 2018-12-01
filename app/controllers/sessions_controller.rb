class SessionsController < ApplicationController

	# Sign in (manual)
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

	# Sign in (OAuth2)
	def create_from_omniauth
		auth_hash = request.env["omniauth.auth"]
		authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

		# If user already exists with this authentication, update the auth token
		if authentication.user
			user = authentication.user
			authentication.update_token(auth_hash)
			@next = root_url
			flash[:notice] = "Signed in with #{auth_hash["provider"]}!"
		else
			# If the user doesn't exist, create a new account using OAuth credentials, confirm details...
			user = User.create_with_auth_and_hash(authentication, auth_hash)
			@next = edit_user_path(user)
			flash[:notice] = "Welcome #{user.full_name}! Please confirm your details!"
		end

		helpers.sign_in(user)
		redirect_to @next
	end

	private
	def session_params
		params.permit(:email, :password)
	end
end
