Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, except: [:destroy, :edit, :update, :new]

  get '/register', to: "users#new"

end
