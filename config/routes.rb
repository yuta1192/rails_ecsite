Rails.application.routes.draw do
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
end
