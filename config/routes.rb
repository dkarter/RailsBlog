Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :sessions, only: [:new, :create]
  get '/login', as: 'login', to: 'sessions#new'
end
