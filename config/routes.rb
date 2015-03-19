Rails.application.routes.draw do


  root to: 'users#index'

  resources :users, except: [:destroy, :edit, :update, :new] do
    resources :photos, only: [:show, :create, :destroy]
  end

  resources :tags, only: [:create, :destroy]

  get '/register', to: "users#new"

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"

end
