Rails.application.routes.draw do
  resources :posts
  resources :sessions, only: [:new, :create]

  get '/login', as: 'login', to: 'sessions#new'
  get '/dashboard', as: 'dashboard', to: 'posts#index'

  root to: 'sessions#new'
end
