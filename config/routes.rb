Rails.application.routes.draw do
	root to: 'welcome#index'

	# Resources :models
	resources :users

	# Sign in routes
	post '/sessions', to: 'sessions#create', as: 'session'
	delete '/sessions', to: 'sessions#destroy', as: 'end_session'

	# OAuth2 routes
	get "/auth/:provider/callback", to: "sessions#create_from_omniauth"

end