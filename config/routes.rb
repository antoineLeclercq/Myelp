Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'businesses#index'

  get '/ui(/:action)', controller: 'ui'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'

  resources :businesses, only: [:new, :create, :index, :show]
  resources :users, only: [:create]
end
