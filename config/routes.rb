Rails.application.routes.draw do
  get 'photo/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/photo", to: "photo#show"
  get "/flow", to: "static_pages#flow"

  resources :registrations, only: [:new, :create]
  resources :users, only: [:show, :index]

  get 'users/:id', to: 'users#show', as: 'user_show'
end
