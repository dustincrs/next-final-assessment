module SessionsHelper

	def signed_in?
		return (session[:user_id]==nil)? false : true
	end

	def sign_in(user)
		return session[:user_id] = user.id
	end

	def sign_out
		return session[:user_id] = nil
	end

	def current_user
		return User.find_by_id(session[:user_id])
	end
end