# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  root to: 'posts#index'
  resources :posts do
    resources :comments, only: :create
  end
  resources :comments, only: :destroy
  resources :likes, only: %i[create destroy]
  resources :friendships, only: %i[create destroy] do
    member do
      patch :accept
      patch :decline
      patch :cancel
    end
  end
end
