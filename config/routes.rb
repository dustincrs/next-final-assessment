Rails.application.routes.draw do
	# "Manual" model routings
	root to: 'welcome#index'
	post '/trials/:id', to: 'trials#check_answer', as: 'check_answer'

	# Resources :models
	resources :users
  	resources :questions
  	resources :trials

	# Sign in routes
	post '/sessions', to: 'sessions#create', as: 'session'
	delete '/sessions', to: 'sessions#destroy', as: 'end_session'

	# OAuth2 routes
	get "/auth/:provider/callback", to: "sessions#create_from_omniauth"

end