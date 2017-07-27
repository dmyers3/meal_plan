Rails.application.routes.draw do
  root to: 'users#front'
  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'home', to: 'users#show'

  resources :users, only: [:create]
end
