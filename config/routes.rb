Rails.application.routes.draw do
  root   'contents#search_index'
  get '/search', to: 'contents#search'
  get    '/about',   to: 'static_pages#about'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get  '/signup',  to: 'users#new'
  resources :users, :only => [:new, :create, :edit, :update]
  resources :contents
    # ブックマーク対象を特定するためURLのcontent_idを利用
    post '/contents/:id/bookmarks', to: 'content_bookmarks#create', as: :create_bookmarks
    delete '/contents/:id/bookmarks', to: 'content_bookmarks#destroy', as: :delete_bookmarks
  resources :content_bookmarks, :only => :index
  resources :events, :except => :show
  resources :memos, :except => :show
  resources :comments, :only => :create
  resources :notifications, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
