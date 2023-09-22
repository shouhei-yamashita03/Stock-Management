Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
  resources :stocks do
    collection { post :import }
    member do
      get 'stock_search'
      get 'search_result'
      get 'stock_detail'
      get 'edit_search_result'
      patch 'update_search_result'
      get 'edit_stock_detail'
      patch 'update_stock_detail'
      delete 'stock_details/:id', to: 'stocks#destroy_stock_detail', as: 'destroy_stock_detail'
    end
    end
  end
end
