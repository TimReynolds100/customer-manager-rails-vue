Rails.application.routes.draw do
  root "home#index"

  get "customers", to: "pages#customers"

  namespace :api do
    get "status", to: "status#index"
    get "customers", to: "customers#index"
    post "customers", to: "customers#create"
    patch "customers/:id", to: "customers#update"
    delete "customers/:id", to: "customers#destroy"
  end
end
