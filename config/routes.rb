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

  resources :photographers do
    resource :like, except: [:get, :index, :show]
    resources :portfolios, only: [:new, :create, :index, :show, :destroy] do
      collection do
        get 'destroy_form'
        delete 'destroy_multiple'
      end
    end
  end





  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/photo', to: 'photo#show'
  get '/flow', to: 'static_pages#flow'
  get 'photo/show'

  resources :photographers, only: %i[edit update index]

  # 開発環境でのメール確認用
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  get 'users/:id', to: 'users#show', as: 'user'
  get 'photographers/:id', to: 'photographers#show'
end
