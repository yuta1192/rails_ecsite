Rails.application.routes.draw do
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
    member do
      get :favorite
      resources :cart_items do
        collection do
          post 'pay/:id' => 'cart_items#pay', as: 'pay'
        end
      end
    end
  end
  resources :sessions
  namespace :admin do
    resources :users
  end
end
