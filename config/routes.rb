# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  devise_for :photographers, controllers: {
    sessions: 'photographers/sessions',
    registrations: 'photographers/registrations',
    confirmations: 'photographers/confirmations'
  }

  resources :users, only: :show do
    resources :requests, only: :show, module: :users
  end

  resources :photographers do
    # ここから下リクエスト
    resources :requests, only: :show, module: :photographers
    # ここまで
    resource :like, except: %i[get index show]
    resources :portfolios, only: %i[new create index show destroy] do
      collection do
        get 'destroy_form'
        delete 'destroy_multiple'
      end
    end
  end

  resources :requests do
    resources :messages, only: [:create]
    get 'user_requests', on: :collection
    member do
      post 'accept'
      post 'decline'
      post 'complete'
    end
  end

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/photo', to: 'photo#show'
  get '/flow', to: 'static_pages#flow'
  get 'photo/show'


  # 開発環境でのメール確認用
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

end
