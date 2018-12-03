Rails.application.routes.draw do
	# "Manual" model routings
	root to: 'welcome#index'
	get		'/trials/:id/fetch_questions', to: 'trials#fetch_questions', as: 'fetch_questions'
	post 	'/trials/:id/check_answer', to: 'trials#check_answer', as: 'check_answer'
  	get 	'/search', to: 'search#show', as: 'search'
  	post	'/search', to: 'search#search', as: 'post_search'

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