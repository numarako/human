Rails.application.routes.draw do
  get 'events/index'
  root   'contents#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get  '/signup',  to: 'users#new'
  resources :users, :except => :show
    get '/users/:id/contents', to: 'users#index_contents', as: :index_contents
    get '/users/:id/bookmarks', to: 'users#index_bookmarks', as: :index_bookmarks
    get '/search', to: 'contents#search'
  resources :contents
    post '/contents/:id/bookmarks', to: 'content_bookmarks#create', as: :create_bookmarks
    delete '/contents/:id/bookmarks', to: 'content_bookmarks#destroy', as: :delete_bookmarks
  resources :events, only: [:index]
    get '/users/:id/events', to: 'events#index', as: :index_events
    post '/users/:id/events', to: 'events#create', as: :create_events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
