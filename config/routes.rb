# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'posts#index'
  devise_for :users
  resources :users, only: :show
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
