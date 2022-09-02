Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], to: 'merchant_items#index'
      end

      get '/items/find', to: 'items#find'

      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], to: 'item_merchant#index'
      end

    end
  end
end
