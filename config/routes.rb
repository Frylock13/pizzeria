Rails.application.routes.draw do
  namespace :admin do
    resources :ingredients
    resources :ingredient_categories, only: [:create, :update]
  end
  resources :orders, only: [:index, :show, :new, :create]
  resources :pages, only: [:show]
  resources :password_resets, only: [:create, :edit, :update]
  resources :user_sessions, only: [:create, :destroy]
  resources :users, only: [:create, :update]
  get :admin, to: 'admin#dashboard'
  get :auth, to: 'user_sessions#new'
  get :login, to: 'user_sessions#new'
  get :logout, to: 'user_sessions#destroy'
  root to: 'products#index'
end
