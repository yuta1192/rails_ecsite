Rails.application.routes.draw do
  resources :home
  resources :product
  resources :user do
    member do
      get :favorite
      get :cart
    end
  end
end
