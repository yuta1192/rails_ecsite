Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'home#index'
  resources :home do
    collection do
      get :connect
      get :sitemap
    end
  end
  resources :products do
    resources :favorites, only: [:create, :destroy]
    collection do
      get :search
    end
  end
  resources :users do
    get :unsubscribed
    member do
      get :favorite
      resources :cart_items do
        collection do
          get :confirmation
          post 'pay/:id' => 'cart_items#pay', as: 'pay'
        end
      end
    end
    resources :product_purchases, only: [:index, :show, :update]
  end
  resources :sessions
  resources :password_resets, only: [:new, :create, :edit, :update]
  namespace :admin do
    resources :orders do
      get :deliverynote
      patch :delivery_update
      patch :finish_flag
      collection { post :import }
    end
    resources :shipments
    resources :users
    resources :products do
      collection do
        get :home
        get :search
      end
    end
  end
end
