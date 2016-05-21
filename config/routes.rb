Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      resources :orders, only: [:index, :show, :update] do
        get :check_updates, on: :collection
        scope module: :orders do
          resources :ordered_pizzas do
            scope module: :ordered_pizzas do
              resources :pizza_ingredients, only: :destroy
            end
          end
          resources :ordered_products
        end
      end
      resources :call_requests, only: :index
      resources :doughs, except: [:show]
      resources :feature_values, only: [:edit, :create, :update, :destroy]
      resources :features, only: [:index, :edit, :create, :update, :destroy]
      resources :ingredient_categories, only: [:edit, :create, :update, :destroy]
      resources :ingredients, except: [:show]
      resources :pages, except: [:show]
      resources :pizza_categories, only: [:edit, :create, :update, :destroy]
      resources :pizzas, except: [:show] do
        get :recalculate
      end
      resources :product_categories, only: [:edit, :create, :update, :destroy]
      resources :products, except: [:show] do
        scope module: :products do
          resources :product_features, except: [:show]
        end
      end
    end
    resources :call_requests, only: [:new, :create] do
      get :thanks, on: :collection
    end
    resources :orders, only: [:index, :show, :new, :update] do
      get :clear
      get :status
    end
    resources :ordered_pizzas, only: [:create] do
      get :decrease
      get :increase
    end
    resources :ordered_products, only: [:create] do
      get :decrease
      get :increase
    end
    resources :pages, only: [:show]
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :pizzas, only: [:new, :create, :destroy] do
      match :recalculate, via: :post, on: :collection
    end
    resources :user_sessions, only: [:new, :create, :destroy]
    resources :users, only: [:new, :create]
    resource :oauth, only: [] do
      match :callback, via: [:get, :post]
      get :index
      get ':provider', action: :run, as: :run
    end
    get :admin, to: 'admin/pages#dashboard'
    get :login, to: 'user_sessions#new'
    get :logout, to: 'user_sessions#destroy'
    get :register, to: 'users#new'
    root to: 'products#index'
  end
end
