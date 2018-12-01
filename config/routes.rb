Rails.application.routes.draw do
	# "Manual" model routings
	root to: 'welcome#index'
  	get 'game/new', as: 'new_game'
  	get 'game/show', as: 'show_game'
  	post 'game/create', as: 'game'
	# Resources :models
	resources :users
  	resources :questions

	# Sign in routes
	post '/sessions', to: 'sessions#create', as: 'session'
	delete '/sessions', to: 'sessions#destroy', as: 'end_session'

	# OAuth2 routes
	get "/auth/:provider/callback", to: "sessions#create_from_omniauth"

end