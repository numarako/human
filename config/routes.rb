Rails.application.routes.draw do
  root   'contents#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get  '/signup',  to: 'users#new'
  resources :users
  get '/search', to: 'contents#search'
  resources :contents
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
