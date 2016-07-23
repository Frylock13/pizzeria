Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      resources :orders, only: [:index, :show, :update, :destroy] do
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
      resources :doughs, except: :show
      resources :feature_values, except: [:index, :new, :show]
      resources :features, except: [:new, :show]
      resources :ingredient_categories, except: [:index, :new, :show]
      resources :ingredients, except: :show
      resources :pages, except: :show
      resources :pizza_categories, except: [:index, :new, :show]

      resources :pizzas, except: :show do
        get :recalculate
      end

      resources :product_categories, except: [:index, :new, :show]

      resources :products, except: :show do
        scope module: :products do
          resources :product_features, except: :show
        end
      end

      root to: 'welcome#index'
    end

    resources :call_requests, only: [:new, :create] do
      get :thanks, on: :collection
    end

    resources :orders, only: [:index, :new, :show, :update] do
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

    resources :pizzas, only: [:new, :create, :destroy] do
      match :recalculate, via: :post, on: :collection
    end

    resources :user_password_resets, only: [:new, :create, :show]
    resources :user_passwords, only: [:edit, :update]
    resources :user_sessions, only: [:new, :create, :destroy]
    resources :users, only: [:new, :create]

    resource :oauth, only: [] do
      match :callback, via: [:get, :post]
      get :index
      get ':provider', action: :run, as: :run
    end

    get :login, to: 'user_sessions#new'
    get :logout, to: 'user_sessions#destroy'
    get :register, to: 'users#new'
    root to: 'products#index'
  end
end
