Rails.application.routes.draw do
	root to: 'welcome#index'

	resources :users
	post '/sessions', to: 'sessions#create', as: 'session'
	delete '/sessions', to: 'sessions#destroy', as: 'end_session'
end