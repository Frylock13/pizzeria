Rails.application.routes.draw do
  namespace :admin do
    resources :doughs
    resources :feature_values, only: [:edit, :create, :update, :destroy]
    resources :features, only: [:index, :edit, :create, :update, :destroy]
    resources :ingredient_categories, only: [:edit, :create, :update, :destroy]
    resources :ingredients
    resources :pages
    resources :pizzas
    resources :product_categories, only: [:edit, :create, :update, :destroy]
    resources :products do
      resources :product_features, controller: 'products/product_features'
    end
  end
  resources :orders, only: [:index, :show, :new, :create]
  resources :pages, only: [:show]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  get :admin, to: 'admin#dashboard'
  get :login, to: 'user_sessions#new'
  get :logout, to: 'user_sessions#destroy'
  get :register, to: 'users#new'
  root to: 'products#index'
end
