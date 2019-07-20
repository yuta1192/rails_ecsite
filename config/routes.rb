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
      get :cart
    end
  end
  resources :sessions
  resources :carts, only: [:show]
  post '/add_item' => 'carts#add_item'
  post '/update_item' => 'carts#update_item'
  delete '/delete_item' => 'carts#delete_item'
end
