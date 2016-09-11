Rails.application.routes.draw do
  resources :posts
  resources :sessions, only: [:new, :create]

  get '/login', as: 'login', to: 'sessions#new'

  root to: 'sessions#new'
end
