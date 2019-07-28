Rails.application.routes.draw do
  root 'home#index'
  resources :home do
    collection do
      get :connect
      get :sitemap
    end
  end
  resources :products
  resources :users do
    member do
      get :favorite
      resources :cart_items
    end
  end
  resources :sessions
end
