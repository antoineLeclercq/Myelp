Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'businesses#index'

  get '/ui(/:action)', controller: 'ui'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'

  resources :users, only: [:create]
  resources :businesses, only: [:new, :create, :index, :show] do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [] do
    collection do
      get :recent, to: :recent
    end
  end
end
