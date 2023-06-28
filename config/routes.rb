Rails.application.routes.draw do
  get 'photographers/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :photographers, controllers: {
    sessions: 'photographers/sessions',
    registrations: 'photographers/registrations'
  }


  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/photo", to: "photo#show"
  get "/flow", to: "static_pages#flow"
  get 'photo/show'

  resources :photographers, only: [:edit, :update]

  #開発環境でのメール確認用
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get 'users/:id', to: 'users#show', as: 'user'
  get 'photographers/:id', to: 'photographers#show'

end
