# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  mount ActionCable.server => '/cable'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users
  resources :account_activations, only: :edit
  root 'static_pages#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#callback'
  get 'auth/failure', to: redirect('/')

  namespace :admin do
    root 'static_pages#home'
    resources :categories
    resources :products do
      resources :auctions
    end
    resources :pictures, only: %i[edit update destroy]
    resources :auctions
    resources :users
    resources :orders, except: %i[new create delete]
  end

  resources :products, only: :show
  resources :auctions, only: :show
  resources :categories, only: :show
  resources :line_items, only: %i[index destroy]
  resources :orders, only: %i[edit update]
end
