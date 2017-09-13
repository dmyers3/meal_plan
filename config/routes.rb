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
  

  resources :users, only: [:create] do
    resources :subscriptions, only: [:new, :create]
  end
  
  namespace :admin do
    resources :ingredients, only: [:index, :show, :new, :create] do
      collection do
        get :autocomplete
      end
    end
    resources :recipes, only: [:index, :show, :new, :create]
    resources :grocery_specials, only: [:create]
    put 'grocery_products', to: 'grocery_products#update'
    resources :grocery_products, only: [:index]
  end
  
  resources :new_passwords, only: [:show, :create]
  get 'expired_token', to: 'new_passwords#expired_token'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
