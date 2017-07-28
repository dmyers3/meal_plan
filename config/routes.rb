Rails.application.routes.draw do
  root to: 'users#front'
  get 'register', to: 'users#new'
  get 'home', to: 'users#show'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
  get 'reset_password', to: 'password_tokens#new'
  post 'reset_password', to: 'password_tokens#create'
  get 'confirm_reset_password', to: 'password_tokens#confirm'
  

  resources :users, only: [:create]
  
  resources :new_passwords, only: [:show, :create]
  get 'expired_token', to: 'new_passwords#expired_token'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
