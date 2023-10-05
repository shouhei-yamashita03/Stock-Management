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
      delete 'search_result/:id', to: 'stocks#destroy_search_result', as: 'destroy_search_result'
      get 'warehouse_arrangement'
    end
    end
  end
end
