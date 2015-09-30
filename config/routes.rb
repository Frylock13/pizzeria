Rails.application.routes.draw do
  resources :orders, only: [:index, :show, :new, :create]
  resources :pages, only: [:index]
  root to: 'products#index'
end
