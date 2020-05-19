# frozen_string_literal: true

Rails.application.routes.draw do
  # root to: 'posts#index'
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show
  resources :posts do
    resources :comments, only: :create
  end
  resources :comments, only: :destroy
  resources :likes, only: %i[create destroy]
  resources :friendships, only: %i[create destroy] do
    collection do
      patch :accept
      patch :decline
      patch :cancel
    end
  end
  resources :friends, only: :index, controller: 'friendships'
end
